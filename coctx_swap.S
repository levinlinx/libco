/*
* Tencent is pleased to support the open source community by making Libco available.

* Copyright (C) 2014 THL A29 Limited, a Tencent company. All rights reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License"); 
* you may not use this file except in compliance with the License. 
* You may obtain a copy of the License at
*
*	http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, 
* software distributed under the License is distributed on an "AS IS" BASIS, 
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
* See the License for the specific language governing permissions and 
* limitations under the License.
*/

.globl coctx_swap
#if !defined( __APPLE__ )
.type  coctx_swap, @function
#endif
coctx_swap:

#if defined(__i386__)
    movl 4(%esp), %eax
    movl %esp,  28(%eax)
    movl %ebp, 24(%eax)
    movl %esi, 20(%eax)
    movl %edi, 16(%eax)
    movl %edx, 12(%eax)
    movl %ecx, 8(%eax)
    movl %ebx, 4(%eax)


    movl 8(%esp), %eax
    movl 4(%eax), %ebx
    movl 8(%eax), %ecx
    movl 12(%eax), %edx
    movl 16(%eax), %edi
    movl 20(%eax), %esi
    movl 24(%eax), %ebp
    movl 28(%eax), %esp

	ret

#elif defined(__x86_64__)
    leaq (%rsp),%rax     ; 保存当前栈指针到rax
    movq %rax, 104(%rdi) ; 保存栈指针到rdi+104
    movq %rbx, 96(%rdi)  ; 保存rbx到rdi+96
    movq %rcx, 88(%rdi)  ; 保存rcx到rdi+88
    movq %rdx, 80(%rdi)  ; 保存rdx到rdi+80
    movq 0(%rax), %rax   ; 加载栈顶值到rax
    movq %rax, 72(%rdi)  ; 保存栈顶值到rdi+72
    movq %rsi, 64(%rdi)  ; 保存rsi到rdi+64
    movq %rdi, 56(%rdi)  ; 保存rdi到rdi+56
    movq %rbp, 48(%rdi)  ; 保存rbp到rdi+48
    movq %r8, 40(%rdi)   ; 保存r8到rdi+40
    movq %r9, 32(%rdi)   ; 保存r9到rdi+32
    movq %r12, 24(%rdi)  ; 保存r12到rdi+24
    movq %r13, 16(%rdi)  ; 保存r13到rdi+16
    movq %r14, 8(%rdi)   ; 保存r14到rdi+8
    movq %r15, (%rdi)    ; 保存r15到rdi
    xorq %rax, %rax      ; 清零rax

    movq 48(%rsi), %rbp  ; 恢复rbp
    movq 104(%rsi), %rsp ; 恢复栈指针
    movq (%rsi), %r15    ; 恢复r15
    movq 8(%rsi), %r14   ; 恢复r14
    movq 16(%rsi), %r13  ; 恢复r13
    movq 24(%rsi), %r12  ; 恢复r12
    movq 32(%rsi), %r9   ; 恢复r9
    movq 40(%rsi), %r8   ; 恢复r8
    movq 56(%rsi), %rdi  ; 恢复rdi
    movq 80(%rsi), %rdx  ; 恢复rdx
    movq 88(%rsi), %rcx  ; 恢复rcx
    movq 96(%rsi), %rbx  ; 恢复rbx
    leaq 8(%rsp), %rsp   ; %rsp += 9 即去掉原有返回地址
    pushq 72(%rsi)       ; 把目标协程的返回地址压入栈

    movq 64(%rsi), %rsi  ; 恢复rsi
	ret
#endif
