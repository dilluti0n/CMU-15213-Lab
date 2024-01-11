# Lab2 BombLab

The original tar file is `bomblab.tar` and the writeup is
`bomblab.pdf`. My solution is in `bomb/defuse_code.txt`.

### Before starting 
The video from `recitation 04` is very helpful. You can start working on this lab after watching `Machine Prog: Control`, but may want to finish the lecture of `Machine Prog: Data` to finish the entire lab.  


### Notes
Inside the directory `bomb`, `bomb` is the binary that you need to defuse by code. If you enter wrong input within the process, `bomb` will `explode`....... you can enter input to the process by `stdin` or using a file redirection like `./bomb defuse_code.txt`.

- `strings.txt` and `symt.txt` is string literal and symbol table included in the binary, respectivaly. but I never used it through solving the lab.
- `disasm.s` is made from `objdump -s ./bomb > disasm.s`, it contains a few comments I wrote while solving the problem, but I stopped writing comments after learning how to use `gdb`.
- When I learned how to use gdb and what exactly the %rsp register does, I realized the necessity of using paper and pen to solve the problems. Diagramming the stack of each `phase_n` was quite helpful in understanding the structure of the process, and probably unnecessary for someone more familiar with `gdb` or other debuggers, as this function is provided by the debugger.
- I even printed disasm.s on A4 paper to review it, which was quite helpful for solving the problems, but probably not what the creator of this lab intended.
- And for everyone who is solving this problem, I recommend that you solve it with an x86-64 cheat sheet, like [this](https://web.stanford.edu/class/cs107/resources/x86-64-reference.pdf), on your desk. The same goes for gdb; printing out it was very helpful to me, who is not familiar with the instructions and register names.

### Solution
SPOILER ALERT: People who want to solve this lab wouldn't want to see the content beyond this point, as it literally spoils everything.

- about `bomb.c`
This provides you with a brief structure of `main`. Each `phase_n` receives the `input` as its argument, which is the return value of the function `read_line`, as its first argument. This means that in every block `phase_n`, `%rdi` contains the memory adress of the each first character of lines you entered. Often, `%rdi` might not be visible in the `phase_n` block, which is because `input` is directly passed as the first argument to functions like `read_six_numbers` or `strings_not_equal`.

- phase_1

```asm
0000000000400ee0 <phase_1>:
  400ee0: 48 83 ec 08                  	subq	$8, %rsp
  400ee4: be 00 24 40 00               	movl	$4203520, %esi          # imm = 0x402400
  400ee9: e8 4a 04 00 00               	callq	0x401338 <strings_not_equal>
  400eee: 85 c0                        	testl	%eax, %eax
  400ef0: 74 05                        	je	0x400ef7 <phase_1+0x17>
  400ef2: e8 43 05 00 00               	callq	0x40143a <explode_bomb>
  400ef7: 48 83 c4 08                  	addq	$8, %rsp
  400efb: c3                           	retq
```

As mentioned earlier, `%rdi` is passed directly to `strings_not_equal`, so it's not explicitly shown in the code. `strings_not_equal` compares the string stored in `(%rdi)` (i.e., `input`) with the one in `(%rsi)`, and returns 0 if they are the same. In this case, `4203520` is stored to `%rsi`, from which we know it's the memory address where the string literal for comparison is stored. By `(gdb) x/s 4203520`, you can find out what the string is, which is "Border relations with Canada have never been better." And this is the defuse code for `phase_1`.