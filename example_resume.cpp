#include <stdio.h>
#include <stdlib.h>
#include "co_routine.h"

// 协程函数
static void* routine_func(void* arg) {
    int co_id = *(int*)arg;
    printf("Coroutine %d: step 1\n", co_id);
    co_yield_ct();  // 第一次让出
    
    printf("Coroutine %d: step 2\n", co_id);
    co_yield_ct();  // 第二次让出
    
    printf("Coroutine %d: completed\n", co_id);
    return NULL;
}

int main() {
    // 初始化协程环境
    stCoRoutine_t* co1 = NULL;
    stCoRoutine_t* co2 = NULL;
    int id1 = 1;

    // 创建两个协程
    co_create(&co1, NULL, routine_func, &id1);

    printf("Main: Start coroutines\n");

    // 交替执行协程1和协程2
    co_resume(co1);  // 启动co1
    co_resume(co1);  // 恢复co1
    co_resume(co1);  // 第二次恢复co1    

    printf("Main: All coroutines completed\n");

    // 释放协程资源
    co_release(co1);


    return 0;
}