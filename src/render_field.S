#include "../lib/mylib.h"

  .att_syntax noprefix
  .global render_field
  
render_field:
 ENTER
 XORALL

  push $0
  push $0
  .set columns, -4
  .set lines, -8 
  .set cursor_row, 8
  .set cursor_column, 12

  movl cursor_row(ebp), edx 
  movl (edx), eax
  imul $10, eax
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  add ecx, eax
  leal cells, edx
  movb $1, 1(edx, eax, 2)

  XORALL
  call print_space  // печатаем space
  call print_space  // печатаем space

numbers_loop:  // печатаем первую строку цифр
  movb numbers(ebx), al  // кладем в al цифру
  push eax
  call putchar
  add $4, esp
  cmp $9, ebx
  jz numbers_out

  incl ebx
  call print_space  // печатаем space
  jmp numbers_loop

numbers_out:
  call print_newline

  xor ebx, ebx  // счетчик для цифр
loop:  // печатаем 10 строчек
  xor eax, eax
  xor ecx, ecx

  movb numbers(ebx), al  // кладем в al цифру
  push eax
  call putchar
  add $4, esp
  incl ebx
  call print_space  // печатаем space

  loop_field:  // печатаем 10 строчек
  // ecx -- колонки
  // eax -- строки

    movl columns(ebp), ecx
    movl lines(ebp), eax
    imul $10, eax
    add eax, ecx  // ecx -- номер ячейки 
    
    xor eax, eax
    leal cells, edx
    movb 1(edx, ecx, 2), al  // открываем ячейку
    cmp $0, al
    jz print_closed_cell


    movb 0(edx, ecx, 2), al  // смотрим мина или нет
    cmp $1, al
    jz found_mine
    push open_empty_cell 
    jmp print_cell

found_mine:
  push mine
  jmp print_cell

print_closed_cell:
  push closed_cell

print_cell:
  call putchar
  add $4, esp

  movl columns(ebp), ecx
  incl ecx
  movl ecx, columns(ebp)
  cmp $10, ecx
  jz make_newline
  call print_space
  jmp loop_field

make_newline:
  xor ecx, ecx
  movl ecx, columns(ebp)

  call print_newline

  movl lines(ebp), eax
  cmp $9, eax
  jz out
 
 incl eax
 movl eax, lines(ebp)
 jmp loop

out:
  leave
  ret
