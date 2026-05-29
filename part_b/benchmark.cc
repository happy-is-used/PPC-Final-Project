#include <iostream>
#include <chrono>
#include <immintrin.h>
#include <omp.h>

int main() {
    float input_val;
    std::cout << "Enter an initial float value (e.g., 1.1): ";
    if (!(std::cin >> input_val)) {
        input_val = 1.0001f;
    }

   
    const long long ITERATIONS = 1500000000LL; 
    const int UNROLL_FACTOR = 12; 

    int num_threads = omp_get_max_threads();
    std::cout << "Running V2 benchmark with " << num_threads << " OpenMP threads..." << std::endl;

    auto start_time = std::chrono::high_resolution_clock::now();
    float global_sum = 0.0f;

    #pragma omp parallel reduction(+:global_sum)
    {
        
        __m256 v0 = _mm256_set1_ps(input_val);
        __m256 v1 = _mm256_set1_ps(input_val + 0.1f);
        __m256 v2 = _mm256_set1_ps(input_val + 0.2f);
        __m256 v3 = _mm256_set1_ps(input_val + 0.3f);
        __m256 v4 = _mm256_set1_ps(input_val + 0.4f);
        __m256 v5 = _mm256_set1_ps(input_val + 0.5f);
        __m256 v6 = _mm256_set1_ps(input_val + 0.6f);
        __m256 v7 = _mm256_set1_ps(input_val + 0.7f);
        __m256 v8 = _mm256_set1_ps(input_val + 0.8f);
        __m256 v9 = _mm256_set1_ps(input_val + 0.9f);
        __m256 v10 = _mm256_set1_ps(input_val + 1.0f);
        __m256 v11 = _mm256_set1_ps(input_val + 1.1f);

        __m256 mul_vec = _mm256_set1_ps(1.0000001f);

        
        for (long long i = 0; i < ITERATIONS; ++i) {
            v0 = _mm256_fmadd_ps(v0, mul_vec, mul_vec);
            v1 = _mm256_fmadd_ps(v1, mul_vec, mul_vec);
            v2 = _mm256_fmadd_ps(v2, mul_vec, mul_vec);
            v3 = _mm256_fmadd_ps(v3, mul_vec, mul_vec);
            v4 = _mm256_fmadd_ps(v4, mul_vec, mul_vec);
            v5 = _mm256_fmadd_ps(v5, mul_vec, mul_vec);
            v6 = _mm256_fmadd_ps(v6, mul_vec, mul_vec);
            v7 = _mm256_fmadd_ps(v7, mul_vec, mul_vec);
            v8 = _mm256_fmadd_ps(v8, mul_vec, mul_vec);
            v9 = _mm256_fmadd_ps(v9, mul_vec, mul_vec);
            v10 = _mm256_fmadd_ps(v10, mul_vec, mul_vec);
            v11 = _mm256_fmadd_ps(v11, mul_vec, mul_vec);
        }

        
        __m256 sum1 = _mm256_add_ps(_mm256_add_ps(v0, v1), _mm256_add_ps(v2, v3));
        __m256 sum2 = _mm256_add_ps(_mm256_add_ps(v4, v5), _mm256_add_ps(v6, v7));
        __m256 sum3 = _mm256_add_ps(_mm256_add_ps(v8, v9), _mm256_add_ps(v10, v11));
        __m256 final_vec = _mm256_add_ps(sum1, _mm256_add_ps(sum2, sum3));

        float local_arr[8];
        _mm256_storeu_ps(local_arr, final_vec);
        float thread_sum = 0.0f;
        for (int j = 0; j < 8; ++j) {
            thread_sum += local_arr[j];
        }
        global_sum += thread_sum;
    }

    auto end_time = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> elapsed = end_time - start_time;

    
    long long total_fma_instructions = ITERATIONS * UNROLL_FACTOR * num_threads;
    long long total_flops = total_fma_instructions * 16;

    double gflops = static_cast<double>(total_flops) / 1e9;
    double achieved_tflops = static_cast<double>(total_flops) / (elapsed.count() * 1e12);

    std::cout << "\n================ Benchmark Results ================" << std::endl;
    std::cout << "Wall-clock Time      : " << elapsed.count() << " seconds" << std::endl;
    std::cout << "Total FLOPs Executed : " << total_flops << " (" << gflops << " GFLOPs)" << std::endl;
    std::cout << "Achieved Performance : " << achieved_tflops << " TFLOPS" << std::endl;
    std::cout << "===================================================" << std::endl;

    return 0;
}