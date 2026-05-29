#pragma GCC optimize("O3,unroll-loops")

#include <cmath>
#include <vector>
#include <omp.h>
#include <algorithm>

void matrix_add(int r, int c, const float* A1, int lda1, const float* A2, int lda2, float* C, int ldc) {
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < r; ++i) {
        #pragma omp simd
        for (int j = 0; j < c; ++j) {
            C[i * ldc + j] = A1[i * lda1 + j] + A2[i * lda2 + j];
        }
    }
}

void matrix_sub(int r, int c, const float* A1, int lda1, const float* A2, int lda2, float* C, int ldc) {
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < r; ++i) {
        #pragma omp simd
        for (int j = 0; j < c; ++j) {
            C[i * ldc + j] = A1[i * lda1 + j] - A2[i * lda2 + j];
        }
    }
}

void block_add(int r, int c, float* C, int ldc, const float* M, int ldm) {
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < r; ++i) {
        #pragma omp simd
        for (int j = 0; j < c; ++j) {
            C[i * ldc + j] += M[i * ldm + j];
        }
    }
}

void block_sub(int r, int c, float* C, int ldc, const float* M, int ldm) {
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < r; ++i) {
        #pragma omp simd
        for (int j = 0; j < c; ++j) {
            C[i * ldc + j] -= M[i * ldm + j];
        }
    }
}


void fallback_gemm_parallel(int n, int m, int p, const float* A, int lda, const float* B, int ldb, float* C, int ldc, bool lower_only) {
    constexpr int BLOCK_I = 64; 
    constexpr int BLOCK_J = 64;  
    constexpr int BLOCK_K = 128; 
    
    
    #pragma omp parallel for schedule(dynamic, 1)
    for (int j = 0; j < p; j += BLOCK_J) {
        int j_end = std::min(j + BLOCK_J, p);
        int j_size = j_end - j;

       
        for (int i = 0; i < n; i += BLOCK_I) {
            int i_end = std::min(i + BLOCK_I, n);
            for (int ii = i; ii < i_end; ++ii) {
                #pragma omp simd
                for (int jj = j; jj < j_end; ++jj) {
                    C[ii * ldc + jj] = 0.0f;
                }
            }
        }

        
        for (int k = 0; k < m; k += BLOCK_K) {
            int k_end = std::min(k + BLOCK_K, m);
            int k_size = k_end - k;
            
            
            alignas(64) float B_pack[BLOCK_K][BLOCK_J];
            for (int kk = 0; kk < k_size; ++kk) {
                const float* b_src = &B[(k + kk) * ldb + j];
                float* b_dst = B_pack[kk];
                #pragma omp simd
                for (int jj = 0; jj < j_size; ++jj) {
                    b_dst[jj] = b_src[jj];
                }
            }
            
            for (int i = 0; i < n; i += BLOCK_I) {
                if (lower_only && j >= i + BLOCK_I) continue;
                
                int i_end = std::min(i + BLOCK_I, n);
                
                for (int ii = i; ii < i_end; ii += 8) {
                    for (int jj = j; jj < j_end; jj += 16) {
                        float c_reg[8][16] = {{0.0f}};
                        
                        for (int kk = 0; kk < k_size; ++kk) {
                            
                            const float* b_vec = B_pack[kk] + (jj - j);
                            for (int x = 0; x < 8; ++x) {
                                float a = A[(ii + x) * lda + k + kk];
                                #pragma omp simd
                                for (int y = 0; y < 16; ++y) {
                                    c_reg[x][y] += a * b_vec[y];
                                }
                            }
                        }
                        
                        for (int x = 0; x < 8; ++x) {
                            #pragma omp simd
                            for (int y = 0; y < 16; ++y) {
                                C[(ii + x) * ldc + jj + y] += c_reg[x][y];
                            }
                        }
                    }
                }
            }
        }
    }
}

void correlate(int ny, int nx, const float *data, float *result) {
    int P_ALIGN = 64;
    int pad_ny = ((ny + P_ALIGN - 1) / P_ALIGN) * P_ALIGN;
    int pad_nx = ((nx + P_ALIGN - 1) / P_ALIGN) * P_ALIGN;

    size_t sz_X = (size_t)pad_ny * pad_nx;
    float* X = new float[sz_X];
    float* XT = new float[sz_X];

    int hn = pad_ny / 2, hm = pad_nx / 2, hp = pad_ny / 2;

    float *M = new float[(size_t)hn * hp];
    float *U = new float[(size_t)hn * hm];
    float *V = new float[(size_t)hm * hp]; 

    size_t sz_C = (size_t)pad_ny * pad_ny;
    float* C = new float[sz_C];
    
    
    #pragma omp parallel for schedule(static)
    for (size_t i = 0; i < sz_X; ++i) X[i] = 0.0f;

    #pragma omp parallel for schedule(static)
    for (size_t i = 0; i < sz_C; ++i) C[i] = 0.0f;

    
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < ny; ++i) {
        double sum = 0.0;
        for (int j = 0; j < nx; ++j) sum += data[i * nx + j];
        double mean = sum / nx;

        double sq_sum = 0.0;
        for (int j = 0; j < nx; ++j) {
            double val = data[i * nx + j] - mean;
            sq_sum += val * val;
        }

        float inv_std = (sq_sum > 0.0) ? (float)(1.0 / std::sqrt(sq_sum)) : 0.0f;
        for (int j = 0; j < nx; ++j) {
            X[i * pad_nx + j] = (float)((data[i * nx + j] - mean) * inv_std);
        }
    }

    #pragma omp parallel for schedule(static) collapse(2)
    for (int i = 0; i < pad_ny; i += 64) {
        for (int j = 0; j < pad_nx; j += 64) {
            int i_end = std::min(i + 64, pad_ny);
            int j_end = std::min(j + 64, pad_nx);
            for (int ii = i; ii < i_end; ++ii) {
                for (int jj = j; jj < j_end; ++jj) {
                    XT[jj * pad_ny + ii] = X[ii * pad_nx + jj];
                }
            }
        }
    }

    int lda = pad_nx, ldb = pad_ny, ldc = pad_ny;
    const float *A11 = X, *A12 = X + hm;
    const float *A21 = X + hn * lda, *A22 = X + hn * lda + hm;
    const float *B11 = XT, *B12 = XT + hp;
    const float *B21 = XT + hm * ldb, *B22 = XT + hm * ldb + hp;

    matrix_add(hn, hm, A11, lda, A22, lda, U, hm);
    matrix_add(hm, hp, B11, ldb, B22, ldb, V, hp);
    fallback_gemm_parallel(hn, hm, hp, U, hm, V, hp, M, hp, true);
    block_add(hn, hp, C, ldc, M, hp);                       
    block_add(hn, hp, C + hn * ldc + hp, ldc, M, hp);       

    matrix_add(hn, hm, A21, lda, A22, lda, U, hm);
    fallback_gemm_parallel(hn, hm, hp, U, hm, B11, ldb, M, hp, false);
    block_add(hn, hp, C + hn * ldc, ldc, M, hp);            
    block_sub(hn, hp, C + hn * ldc + hp, ldc, M, hp);       

    matrix_sub(hm, hp, B12, ldb, B22, ldb, V, hp);
    fallback_gemm_parallel(hn, hm, hp, A11, lda, V, hp, M, hp, true);
    block_add(hn, hp, C + hn * ldc + hp, ldc, M, hp);       

    matrix_sub(hm, hp, B21, ldb, B11, ldb, V, hp);
    fallback_gemm_parallel(hn, hm, hp, A22, lda, V, hp, M, hp, false);
    block_add(hn, hp, C, ldc, M, hp);                       
    block_add(hn, hp, C + hn * ldc, ldc, M, hp);            

    matrix_add(hn, hm, A11, lda, A12, lda, U, hm);
    fallback_gemm_parallel(hn, hm, hp, U, hm, B22, ldb, M, hp, true);
    block_sub(hn, hp, C, ldc, M, hp);                       

    matrix_sub(hn, hm, A21, lda, A11, lda, U, hm);
    matrix_add(hm, hp, B11, ldb, B12, ldb, V, hp);
    fallback_gemm_parallel(hn, hm, hp, U, hm, V, hp, M, hp, true);
    block_add(hn, hp, C + hn * ldc + hp, ldc, M, hp);       

    matrix_sub(hn, hm, A12, lda, A22, lda, U, hm);
    matrix_add(hm, hp, B21, ldb, B22, ldb, V, hp);
    fallback_gemm_parallel(hn, hm, hp, U, hm, V, hp, M, hp, true);
    block_add(hn, hp, C, ldc, M, hp);                       

    #pragma omp parallel for schedule(dynamic)
    for (int i = 0; i < ny; ++i) {
        for (int j = 0; j <= i; ++j) {
            result[i + j * ny] = C[i * pad_ny + j];
        }
    }

    delete[] X;
    delete[] XT;
    delete[] M;
    delete[] U;
    delete[] V;
    delete[] C;
}