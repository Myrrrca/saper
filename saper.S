#include "./lib/mylib.h"

  .global main
  .global instructions
  .global cells
  .global newline
  .global space
  .global numbers
  .global closed_cell
  .global mine
  .global cursor
  .global open_empty_cell
  .att_syntax noprefix

init_cells:
  ENTER

  XORALL

  // edx -- счетчик клеток
  
  lea rand, ebx  // адрес буффера
  mov $100, ecx  // размер буфера
  mov $355, eax  // номер сисколла
  int $0x80

fill_cells:

  xor eax, eax
  movb rand(, edx, 1), al  // заполняем sl случайно заполненным байтом
  cmp $20, eax  // 13% шанс клетка становится миной 
  jc do_mine

  movb $0, cells(,edx, 2)  // клетка не мина
  movb cells(,edx, 2), al // проверяем значение в памяти 
  jmp cell_end

do_mine:
  movb $1, cells(,edx, 2)  // делаем клетку миной
  movb cells(,edx, 2), al // проверяем значение в памяти 


cell_end:
  incl edx
  cmp $99, edx
  jz cells_end 
  jmp fill_cells

cells_end:
  leave
  ret
  
  leave
  ret

main:
  ENTER

  call init_cells

/*
  push $cells
  push $cursor_row
  push $cursor_column
  call render_field
  add $12, esp
  */

  //call print_newline
  call check_field
  //call print_instructions



  movl $1, cursor_column
  movl $1, cursor_row
  
  push $cursor_column
  push $cursor_row
  call render_field
  add $8, esp
  

  leave
  ret

  .section .rodata
closed_cell:
  .byte '#'

open_empty_cell:
  .byte 'O'

mine:
  .byte '*'

cursor:
  .byte '@'

newline:
  .byte 10

space:
  .byte 32

numbers:
  .ascii "0123456789"

instructions:
  .asciz "enter the column number and line number separated by space and press enter:"

  .bss
cells:
  // 100 клеток у каждой из которых есть содержание и статус
  // содержание -- мина / цифра
  // статус -- открыта / закрыта

  .skip 10 * 10 * 2

rand:
  .skip 10 * 10

.data
cursor_row:
  .int 0

cursor_column:
  .int 0
