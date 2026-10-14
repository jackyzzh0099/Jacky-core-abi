/* 要求：完整保存程序执行所需上下文；切回后调用者应能继续往下执行。 */
#ifndef CONTEXT_H
#define CONTEXT_H
    
    //加上最后一行 #endif ，这三行是一个条件编译块
    //作用是：保证这个头文件在同一个编译单元里只被展开一次。
    //防止重复定义


#include <stdint.h>
    //这是 C 标准库的头文件，提供固定宽度的整数类型
    

typedef struct {

    uint64_t rsp;   // 栈指针
    uint64_t rbp;   // 栈帧基址
    uint64_t rbx;   // 被调用者保存
    uint64_t r12;
    uint64_t r13;
    uint64_t r14;
    uint64_t r15;
    uint64_t rip;   // 返回地址

} context_t;

int set_ctx(context_t *ctx);
void jmp_to(context_t *ctx, int value);
            // 定义函数接口

#endif