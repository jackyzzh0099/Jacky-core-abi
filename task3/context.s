.text                             # 进入代码段
.globl set_ctx
.globl jmp_to                     # 把函数符号导出，链接器才能看到

.type set_ctx, @function          
.type jmp_to, @function           # 告诉汇编器定义的是函数



set_ctx:
    leaq    8(%rsp), %rax
    movq    %rax, (%rdi)          # ctx->rsp = 栈顶地址（调整后）

    mov %rbp, 0x08(%rdi)          # 将原始 rbp 存在结构体的 rbp 中
    mov %rbx, 0x10(%rdi)          # 调用者其他寄存器保存
    mov %r12, 0x18(%rdi) 
    mov %r13, 0x20(%rdi)
    mov %r14, 0x28(%rdi)
    mov %r15, 0x30(%rdi)

    movq    (%rsp), %rax
    movq    %rax, 0x38(%rdi)      # ctx->rip = 返回地址

    mov $0x00, %eax               # 模拟 setjmp 在保存后返回 0
   
    ret                           # 返回

    .size set_ctx, .-set_ctx      # 记录函数大小，给调试器和链接器用
    



jmp_to:

    mov %esi, %eax                # 更新返回值

    movq (%rdi), %rsp
    movq 0x08(%rdi), %rbp         # 恢复栈帧

    movq 0x10(%rdi), %rbx
    movq 0x18(%rdi), %r12
    movq 0x20(%rdi), %r13
    movq 0x28(%rdi), %r14
    movq 0x30(%rdi), %r15         # 恢复其他寄存器

    .size jmp_to, .-jmp_to        # 记录函数大小，给调试器和链接器用
    
    jmp *0x38(%rdi)               # 跳回

    

