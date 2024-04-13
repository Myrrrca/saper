#include "mylib.h"

  .global main
  .att_syntax noprefix

render_field:
  ENTER

  push $0
  push $0
  .set columns, -4
  .set lines, -8 


loop:
  xor eax, eax
  xor ecx, ecx
  movb closed_cell, al  // кладем в al '#'
  loop2:  // печатаем колонки
    push eax
    call putchar
    add $4, esp
    movl columns(ebp), ecx  // смотрим на наш счетчик 
    cmp $9, ecx
    jz out2

    incl ecx  // инрементим счетчик
    movl ecx, columns(ebp)
    jmp loop2

  out2:
    xor eax, eax
    xor ecx, ecx
    movl ecx, columns(ebp) // обновляем счетчик колонок

    movb newline, al  // кладем в al '\n'
    push eax
    call putchar  // печатаем новую строку
    add $4, esp

    movl lines(ebp), ecx  // смотрим на наш счетчик 
    cmp $9, ecx
    jz out

    incl ecx  // инрементим счетчик
    movl ecx, lines(ebp)
    jmp loop

out:
  leave
  ret

main:
  ENTER
  xor eax, eax

  call render_field
  

  leave
  ret

  .section .rodata
closed_cell:
  .byte '#'

open_empty_cell:
  .byte 'O'

open_mine:
  .byte '*'

cursor:
  .byte '@'

newline:
  .byte 10

numbers:
  .asciz "0123456789"
