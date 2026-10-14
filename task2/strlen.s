.text                               # 进入代码段
.globl my_strlen                    # 把 my_strlen 符号导出，链接器才能看到
.type my_strlen, @function          # 告诉汇编器：my_strlen 是一个函数

my_strlen:
    push %rbp                       # 保存调用者栈帧
    mov %rsp, %rbp                  # 建立栈帧
    mov $0x00, %rax                 # 建立计数器（同时是返回值寄存器）= 0 

.Lloop:                             # 局部标签 .Lloop
    movb (%rdi,%rax,1), %r8b        # 从目标字符串地址读 1 字节，并自动寻址读下一个
    testb %r8b, %r8b                # 检验该字节是否是 0（\0的 ASCII 是 0
    je .Ldone                       # 如果是 \0 跳转至 .Ldone
    add $0x01, %rax                 # 否则 rax++
    jmp .Lloop                      # 再次回到 .Lloop 继续循环

.Ldone:
    leave                           
    ret
                                    # 恢复栈帧并返回

    .size my_strlen, .-my_strlen    # 记录函数大小，给调试器和链接器用              
