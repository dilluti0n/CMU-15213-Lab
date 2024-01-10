	.file	"pseudocode.c"
	.text
	.globl	explode_bomb
	.type	explode_bomb, @function
explode_bomb:
.LFB22:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$1, %edi
	call	exit@PLT
	.cfi_endproc
.LFE22:
	.size	explode_bomb, .-explode_bomb
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d %d %d %d %d %d"
	.text
	.globl	read_six_numbers
	.type	read_six_numbers, @function
read_six_numbers:
.LFB23:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	%rsi, %rdx
	leaq	4(%rsi), %rcx
	leaq	20(%rsi), %rax
	pushq	%rax
	.cfi_def_cfa_offset 24
	leaq	16(%rsi), %rax
	pushq	%rax
	.cfi_def_cfa_offset 32
	leaq	12(%rsi), %r9
	leaq	8(%rsi), %r8
	leaq	.LC0(%rip), %rsi
	movl	$0, %eax
	call	__isoc99_sscanf@PLT
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	cmpl	$5, %eax
	jle	.L7
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L7:
	.cfi_restore_state
	movl	$0, %eax
	call	explode_bomb
	.cfi_endproc
.LFE23:
	.size	read_six_numbers, .-read_six_numbers
	.globl	phase_2
	.type	phase_2, @function
phase_2:
.LFB24:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rsp, %rsi
	call	read_six_numbers
	movl	(%rsp), %eax
	cmpl	$1, %eax
	jne	.L9
	addl	%eax, %eax
	cmpl	%eax, 4(%rsp)
	jne	.L13
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L13:
	.cfi_restore_state
	movl	$0, %eax
	call	explode_bomb
.L9:
	movl	$0, %eax
	call	explode_bomb
	.cfi_endproc
.LFE24:
	.size	phase_2, .-phase_2
	.globl	main
	.type	main, @function
main:
.LFB25:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$0, %edi
	call	phase_2
	movl	$0, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE25:
	.size	main, .-main
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits
