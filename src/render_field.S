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
  add ecx, eax  // номер ячейка
  leal cells, edx
  movb $1, 1(edx, eax, 2)

  xor ecx, ecx
  movb 0(edx, eax, 2), cl
  cmp $1, cl
  jz do_nothing  // открыли мину 
  cmp $0, eax
  jz opened_first_cell
  cmp $10, eax
  jbe opened_first_row
  cmp $90, eax
  jge opened_last_row
  cmp $99, eax
  jz opened_last_cell
  cmp $9, eax
  jz opened_top_right
  cmp $90, eax
  jz opened_bottom_left

  xor edx, edx  // остаток от деления
  // в eax число которое делим
  movl $10, ebx
  idiv ebx
  test edx, edx  // левая граница
  jz opened_left_border
  cmp $9, edx  // правая граница
  jz opened_right_border


  movl cursor_row(ebp), edx 
  movl (edx), eax
  imul $10, eax
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  add ecx, eax  // номер ячейка
  leal cells, edx
  xor ecx, ecx
  movb 2(edx, eax, 2), cl  // ecx -- значение правой клетки
  cmp $1, ecx
  jz 1f
  movb $1, 3(edx, eax, 2)
1:
  movb -2(edx, eax, 2), cl  // ecx -- значение левой клетки
  cmp $1, ecx
  jz 1f
  movb $1, -1(edx, eax, 2)
1:
  movb 20(edx, eax, 2), cl  // ecx -- значение нижней клетки
  cmp $1, ecx
  jz 1f
  movb $1, 21(edx, eax, 2)
1:
  movb -20(edx, eax, 2), cl  // ecx -- значение верхней клетки
  cmp $1, ecx
  jz 1f
  movb $1, -19(edx, eax, 2)
1:
  jmp do_nothing

opened_first_cell:
  leal cells, edx
  xor ecx, ecx
  movb 2(edx, eax, 2), cl  // ecx -- значение правой клетки
  cmp $1, ecx
  jz 1f
  movb $1, 3(edx, eax, 2)
1:
  movb 20(edx, eax, 2), cl  // ecx -- значение нижей клетки
  cmp $1, ecx
  jz 1f
  movb $1, 21(edx, eax, 2)
1:
  jmp do_nothing

opened_first_row:
  leal cells, edx
  xor ecx, ecx
  movb 2(edx, eax, 2), cl  // ecx -- значение правой клетки
  cmp $1, ecx
  jz 1f
  movb $1, 3(edx, eax, 2)
1:
  movb -2(edx, eax, 2), cl  // ecx -- значение левой клетки
  cmp $1, ecx
  jz 1f
  movb $1, -1(edx, eax, 2)
1:
  movb 20(edx, eax, 2), cl  // ecx -- значение нижней клетки
  cmp $1, ecx
  jz 1f
  movb $1, 21(edx, eax, 2)
1:
  jmp do_nothing

opened_last_row:
  leal cells, edx
  xor ecx, ecx
  movb 2(edx, eax, 2), cl  // ecx -- значение правой клетки
  cmp $1, ecx
  jz 1f
  movb $1, 3(edx, eax, 2)
1:
  movb -2(edx, eax, 2), cl  // ecx -- значение левой клетки
  cmp $1, ecx
  jz 1f
  movb $1, -1(edx, eax, 2)
1:
  movb -20(edx, eax, 2), cl  // ecx -- значение верхней клетки
  cmp $1, ecx
  jz 1f
  movb $1, -19(edx, eax, 2)
1:
  jmp do_nothing

opened_last_cell:
  leal cells, edx
  xor ecx, ecx
  movb -2(edx, eax, 2), cl  // ecx -- значение левой клетки
  cmp $1, ecx
  jz 1f
  movb $1, -1(edx, eax, 2)
1:
  movb -20(edx, eax, 2), cl  // ecx -- значение верхней клетки
  cmp $1, ecx
  jz 1f
  movb $1, -19(edx, eax, 2)
1:
  jmp do_nothing

opened_top_right:
  leal cells, edx
  xor ecx, ecx
  movb -2(edx, eax, 2), cl  // ecx -- значение левой клетки
  cmp $1, ecx
  jz 1f
  movb $1, -1(edx, eax, 2)
1:
  movb 20(edx, eax, 2), cl  // ecx -- значение нижней клетки
  cmp $1, ecx
  jz 1f
  movb $1, 21(edx, eax, 2)
1:
  jmp do_nothing

opened_bottom_left:
  leal cells, edx
  xor ecx, ecx
  movb 2(edx, eax, 2), cl  // ecx -- значение правой клетки
  cmp $1, ecx
  jz 1f
  movb $1, 3(edx, eax, 2)
1:
  movb -20(edx, eax, 2), cl  // ecx -- значение верхней клетки
  cmp $1, ecx
  jz 1f
  movb $1, -19(edx, eax, 2)
1:
  jmp do_nothing

opened_left_border:
  movl cursor_row(ebp), edx 
  movl (edx), eax
  imul $10, eax
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  add ecx, eax  // номер ячейка
  leal cells, edx
  xor ecx, ecx
  movb 2(edx, eax, 2), cl  // ecx -- значение правой клетки
  cmp $1, ecx
  jz 1f
  movb $1, 3(edx, eax, 2)
1:
  movb 20(edx, eax, 2), cl  // ecx -- значение нижней клетки
  cmp $1, ecx
  jz 1f
  movb $1, 21(edx, eax, 2)
1:
  movb -20(edx, eax, 2), cl  // ecx -- значение верхней клетки
  cmp $1, ecx
  jz 1f
  movb $1, -19(edx, eax, 2)
1:
  jmp do_nothing

opened_right_border:
  movl cursor_row(ebp), edx 
  movl (edx), eax
  imul $10, eax
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  add ecx, eax  // номер ячейка
  leal cells, edx
  xor ecx, ecx
  movb -2(edx, eax, 2), cl  // ecx -- значение левой клетки
  cmp $1, ecx
  jz 1f
  movb $1, -1(edx, eax, 2)
1:
  movb 20(edx, eax, 2), cl  // ecx -- значение нижней клетки
  cmp $1, ecx
  jz 1f
  movb $1, 21(edx, eax, 2)
1:
  movb -20(edx, eax, 2), cl  // ecx -- значение верхней клетки
  cmp $1, ecx
  jz 1f
  movb $1, -19(edx, eax, 2)
1:
  jmp do_nothing
  

do_nothing:
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
    push 0(edx, ecx, 2)  
    jmp print_cell

found_mine:
  push mine
  jmp print_cell

print_closed_cell:
  push closed_cell
  jmp print_cell

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
