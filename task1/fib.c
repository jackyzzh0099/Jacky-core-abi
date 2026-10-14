#include<stdio.h>
// 索引从 0 开始，0,1,1,2,3,5,...
long long fib(int x){
    if (x < 0)
        return 0;
    if (x < 2)
        return x;
                        //特殊返回单独判断
    
    long long i , a=0 , b=1 , c;
   
    for (i = 2;i <= x; i++){       //循环 x-1 次
        c = a + b;
        a = b;
        b = c;      //迭代
    }
    return c;
    
} 