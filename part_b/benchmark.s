	.file	"benchmark.cc"
	.text
#APP
	.globl _ZSt21ios_base_library_initv
#NO_APP
	.p2align 4
	.type	main._omp_fn.0, @function
main._omp_fn.0:
.LFB9336:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	endbr64
	vbroadcastss	.LC13(%rip), %ymm0
	movq	(%rdi), %rax
	movq	%rdi, %rdx
	vmovss	(%rax), %xmm1
	vaddss	.LC0(%rip), %xmm1, %xmm7
	movl	$1500000000, %eax
	vaddss	.LC1(%rip), %xmm1, %xmm3
	vaddss	.LC2(%rip), %xmm1, %xmm8
	vaddss	.LC3(%rip), %xmm1, %xmm4
	vaddss	.LC4(%rip), %xmm1, %xmm12
	vbroadcastss	%xmm1, %ymm6
	vaddss	.LC5(%rip), %xmm1, %xmm2
	vaddss	.LC6(%rip), %xmm1, %xmm9
	vbroadcastss	%xmm7, %ymm7
	vaddss	.LC7(%rip), %xmm1, %xmm5
	vbroadcastss	%xmm3, %ymm3
	vbroadcastss	%xmm8, %ymm8
	vaddss	.LC8(%rip), %xmm1, %xmm10
	vbroadcastss	%xmm4, %ymm4
	vbroadcastss	%xmm12, %ymm12
	vaddss	.LC9(%rip), %xmm1, %xmm11
	vbroadcastss	%xmm2, %ymm2
	vbroadcastss	%xmm9, %ymm9
	vaddss	.LC10(%rip), %xmm1, %xmm1
	vbroadcastss	%xmm5, %ymm5
	vbroadcastss	%xmm10, %ymm10
	vbroadcastss	%xmm11, %ymm11
	vbroadcastss	%xmm1, %ymm1
	.p2align 4,,10
	.p2align 3
.L2:
	vfmadd132ps	%ymm0, %ymm0, %ymm6
	vfmadd132ps	%ymm0, %ymm0, %ymm7
	subq	$1, %rax
	vfmadd132ps	%ymm0, %ymm0, %ymm3
	vfmadd132ps	%ymm0, %ymm0, %ymm8
	vfmadd132ps	%ymm0, %ymm0, %ymm4
	vfmadd132ps	%ymm0, %ymm0, %ymm12
	vfmadd132ps	%ymm0, %ymm0, %ymm2
	vfmadd132ps	%ymm0, %ymm0, %ymm9
	vfmadd132ps	%ymm0, %ymm0, %ymm5
	vfmadd132ps	%ymm0, %ymm0, %ymm10
	vfmadd132ps	%ymm0, %ymm0, %ymm11
	vfmadd132ps	%ymm0, %ymm0, %ymm1
	jne	.L2
	vaddps	%ymm12, %ymm4, %ymm4
	vaddps	%ymm1, %ymm11, %ymm0
	vaddps	%ymm9, %ymm2, %ymm2
	vaddps	%ymm10, %ymm5, %ymm5
	vaddps	%ymm7, %ymm6, %ymm6
	leaq	8(%rdx), %rcx
	movl	8(%rdx), %edx
	vaddps	%ymm4, %ymm2, %ymm2
	vaddps	%ymm5, %ymm0, %ymm0
	vxorps	%xmm4, %xmm4, %xmm4
	vaddps	%ymm0, %ymm2, %ymm1
	vaddps	%ymm8, %ymm3, %ymm0
	vaddps	%ymm6, %ymm0, %ymm0
	vaddps	%ymm0, %ymm1, %ymm1
	vaddss	%xmm4, %xmm1, %xmm2
	vshufps	$85, %xmm1, %xmm1, %xmm3
	vshufps	$255, %xmm1, %xmm1, %xmm0
	vaddss	%xmm2, %xmm3, %xmm3
	vunpckhps	%xmm1, %xmm1, %xmm2
	vextractf128	$0x1, %ymm1, %xmm1
	vaddss	%xmm3, %xmm2, %xmm2
	vaddss	%xmm2, %xmm0, %xmm0
	vshufps	$85, %xmm1, %xmm1, %xmm2
	vaddss	%xmm1, %xmm0, %xmm0
	vaddss	%xmm2, %xmm0, %xmm0
	vunpckhps	%xmm1, %xmm1, %xmm2
	vshufps	$255, %xmm1, %xmm1, %xmm1
	vaddss	%xmm2, %xmm0, %xmm0
	vaddss	%xmm1, %xmm0, %xmm0
	vaddss	%xmm4, %xmm0, %xmm0
.L3:
	vmovd	%edx, %xmm7
	movl	%edx, %eax
	vaddss	%xmm7, %xmm0, %xmm6
	vmovd	%xmm6, %esi
	lock cmpxchgl	%esi, (%rcx)
	jne	.L11
	vzeroupper
	ret
.L11:
	movl	%eax, %edx
	jmp	.L3
	.cfi_endproc
.LFE9336:
	.size	main._omp_fn.0, .-main._omp_fn.0
	.p2align 4
	.type	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.isra.0, @function
_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.isra.0:
.LFB9339:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	(%rdi), %rax
	movq	-24(%rax), %rax
	movq	240(%rdi,%rax), %rbp
	testq	%rbp, %rbp
	je	.L17
	cmpb	$0, 56(%rbp)
	movq	%rdi, %rbx
	je	.L14
	movsbl	67(%rbp), %esi
.L15:
	movq	%rbx, %rdi
	call	_ZNSo3putEc@PLT
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	movq	%rax, %rdi
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	_ZNSo5flushEv@PLT
.L14:
	.cfi_restore_state
	movq	%rbp, %rdi
	call	_ZNKSt5ctypeIcE13_M_widen_initEv@PLT
	movq	0(%rbp), %rax
	movl	$10, %esi
	movq	%rbp, %rdi
	call	*48(%rax)
	movsbl	%al, %esi
	jmp	.L15
.L17:
	call	_ZSt16__throw_bad_castv@PLT
	.cfi_endproc
.LFE9339:
	.size	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.isra.0, .-_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.isra.0
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC14:
	.string	"Enter an initial float value (e.g., 1.1): "
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC16:
	.string	"Running V2 benchmark with "
.LC17:
	.string	" OpenMP threads..."
	.section	.rodata.str1.8
	.align 8
.LC20:
	.string	"\n================ Benchmark Results ================"
	.section	.rodata.str1.1
.LC21:
	.string	"Wall-clock Time      : "
.LC22:
	.string	" seconds"
.LC23:
	.string	"Total FLOPs Executed : "
.LC24:
	.string	" ("
.LC25:
	.string	" GFLOPs)"
.LC26:
	.string	"Achieved Performance : "
.LC27:
	.string	" TFLOPS"
	.section	.rodata.str1.8
	.align 8
.LC28:
	.string	"==================================================="
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB8762:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movl	$42, %edx
	leaq	.LC14(%rip), %rsi
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	leaq	_ZSt4cout(%rip), %rbx
	movq	%rbx, %rdi
	subq	$88, %rsp
	.cfi_def_cfa_offset 128
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	leaq	44(%rsp), %r13
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	movq	%r13, %rsi
	leaq	_ZSt3cin(%rip), %rdi
	call	_ZNSi10_M_extractIfEERSiRT_@PLT
	movq	(%rax), %rdx
	movq	-24(%rdx), %rdx
	testb	$5, 32(%rax,%rdx)
	je	.L19
	movl	$0x3f800347, 44(%rsp)
.L19:
	call	omp_get_max_threads@PLT
	movl	$26, %edx
	leaq	.LC16(%rip), %rsi
	movq	%rbx, %rdi
	movslq	%eax, %rbp
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	movl	%ebp, %esi
	movq	%rbx, %rdi
	call	_ZNSolsEi@PLT
	movl	$18, %edx
	leaq	.LC17(%rip), %rsi
	movq	%rax, %r12
	movq	%rax, %rdi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	movq	%r12, %rdi
	call	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.isra.0
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	leaq	48(%rsp), %rsi
	leaq	main._omp_fn.0(%rip), %rdi
	movq	%rax, %r12
	movq	%r13, 48(%rsp)
	movl	$0x00000000, 56(%rsp)
	call	GOMP_parallel@PLT
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	vxorps	%xmm1, %xmm1, %xmm1
	movq	%rbx, %rdi
	vmovsd	.LC18(%rip), %xmm2
	subq	%r12, %rax
	movl	$52, %edx
	leaq	.LC20(%rip), %rsi
	vcvtsi2sdq	%rax, %xmm1, %xmm0
	movabsq	$288000000000, %rax
	imulq	%rax, %rbp
	vdivsd	%xmm2, %xmm0, %xmm0
	vcvtsi2sdq	%rbp, %xmm1, %xmm1
	vdivsd	%xmm2, %xmm1, %xmm3
	vmulsd	.LC19(%rip), %xmm0, %xmm2
	vmovsd	%xmm0, 24(%rsp)
	vdivsd	%xmm2, %xmm1, %xmm4
	vmovsd	%xmm3, 8(%rsp)
	vmovsd	%xmm4, 16(%rsp)
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	movq	%rbx, %rdi
	call	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.isra.0
	movl	$23, %edx
	leaq	.LC21(%rip), %rsi
	movq	%rbx, %rdi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	vmovsd	24(%rsp), %xmm0
	movq	%rbx, %rdi
	call	_ZNSo9_M_insertIdEERSoT_@PLT
	movl	$8, %edx
	leaq	.LC22(%rip), %rsi
	movq	%rax, %r12
	movq	%rax, %rdi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	movq	%r12, %rdi
	call	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.isra.0
	movl	$23, %edx
	leaq	.LC23(%rip), %rsi
	movq	%rbx, %rdi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	_ZNSo9_M_insertIxEERSoT_@PLT
	movl	$2, %edx
	leaq	.LC24(%rip), %rsi
	movq	%rax, %rdi
	movq	%rax, %rbp
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	vmovsd	8(%rsp), %xmm0
	movq	%rbp, %rdi
	call	_ZNSo9_M_insertIdEERSoT_@PLT
	movl	$8, %edx
	leaq	.LC25(%rip), %rsi
	movq	%rax, %rbp
	movq	%rax, %rdi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	movq	%rbp, %rdi
	call	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.isra.0
	movl	$23, %edx
	leaq	.LC26(%rip), %rsi
	movq	%rbx, %rdi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	vmovsd	16(%rsp), %xmm0
	movq	%rbx, %rdi
	call	_ZNSo9_M_insertIdEERSoT_@PLT
	movl	$7, %edx
	leaq	.LC27(%rip), %rsi
	movq	%rax, %rbp
	movq	%rax, %rdi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	movq	%rbp, %rdi
	call	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.isra.0
	movl	$51, %edx
	leaq	.LC28(%rip), %rsi
	movq	%rbx, %rdi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	movq	%rbx, %rdi
	call	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.isra.0
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L25
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L25:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE8762:
	.size	main, .-main
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC0:
	.long	1036831949
	.align 4
.LC1:
	.long	1045220557
	.align 4
.LC2:
	.long	1050253722
	.align 4
.LC3:
	.long	1053609165
	.align 4
.LC4:
	.long	1056964608
	.align 4
.LC5:
	.long	1058642330
	.align 4
.LC6:
	.long	1060320051
	.align 4
.LC7:
	.long	1061997773
	.align 4
.LC8:
	.long	1063675494
	.align 4
.LC9:
	.long	1065353216
	.align 4
.LC10:
	.long	1066192077
	.align 4
.LC13:
	.long	1065353217
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC18:
	.long	0
	.long	1104006501
	.align 8
.LC19:
	.long	-1577058304
	.long	1114446484
	.hidden	DW.ref.__gxx_personality_v0
	.weak	DW.ref.__gxx_personality_v0
	.section	.data.rel.local.DW.ref.__gxx_personality_v0,"awG",@progbits,DW.ref.__gxx_personality_v0,comdat
	.align 8
	.type	DW.ref.__gxx_personality_v0, @object
	.size	DW.ref.__gxx_personality_v0, 8
DW.ref.__gxx_personality_v0:
	.quad	__gxx_personality_v0
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
