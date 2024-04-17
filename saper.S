#include "./lib/mylib.h"

  .global main
  .global instructions
  .global real_field_text
  .global cells
  .global newline
  .global space
  .global numbers
  .global closed_cell
  .global mine
  .global cursor
  .global open_empty_cell
  .global scanf_separator
  .att_syntax noprefix

init_cells:
  ENTER
  XORALL

  lea rand, ebx  // адрес буффера
  mov $100, ecx  // размер буфера
  mov $355, eax  // номер сисколла
  int $0x80

fill_cells:
  // edx -- счетчик клеток

  xor eax, eax
  movb rand(, edx, 1), al  // заполняем sl случайно заполненным байтом
  cmp $20, eax  // 13% шанс клетка становится миной 
  jc do_mine

  movb $48, cells(,edx, 2)  // клетка не мина
  movb cells(,edx, 2), al // проверяем значение в памяти 
  jmp cell_end

do_mine:
  movb $1, cells(,edx, 2)  // делаем клетку миной
  movb cells(,edx, 2), al // проверяем значение в памяти 

cell_end:
  incl edx
  cmp $100, edx
  jz cells_end 
  jmp fill_cells

cells_end:
  leave
  ret


init_numbers:
  ENTER
  XORALL

fill_numbers:
// edx -- адрес cells
// ebx -- счетчик клеток
  leal cells, edx
  xor eax, eax
  movb cells(, ebx, 2), al
  cmp $1, al
  jz mine_found
  jmp next_cell
  

mine_found:
  cmp $0, ebx
  jz mine_found_first 
  cmp $10, ebx
  jbe mine_found_lower_10
  cmp $90, ebx
  jge mine_found_higher_90
  cmp $99, ebx
  jz mine_found_last
  cmp $9, ebx
  jz mine_found_top_right
  cmp $90, ebx
  jz mine_found_bottom_left


  xor edx, edx  // остаток от деления
  mov ebx, eax  // число которое делим
  movl $10, ecx
  idiv ecx
  test edx, edx  // левая граница
  jz mine_found_left_border
  cmp $9, edx  // правая граница
  jz mine_found_right_border


  leal cells, edx
  xor eax, eax
  movb -2(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb -2(edx, ebx, 2) 
1:
  movb 2(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb 2(edx, ebx, 2)
1:
  movb 20(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb 20(edx, ebx, 2)
1:
  movb -20(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb -20(edx, ebx, 2)
1:
  jmp next_cell 

mine_found_first:
  leal cells, edx
  xor eax, eax
  movb 2(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb 2(edx, ebx, 2)
1:
  movb 20(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb 20(edx, ebx, 2)
1:
  jmp next_cell

mine_found_lower_10:
  leal cells, edx
  xor eax, eax
  movb -2(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb -2(edx, ebx, 2) 
1:
  movb 2(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb 2(edx, ebx, 2)
1:
  movb 20(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb 20(edx, ebx, 2)
1:
  jmp next_cell

mine_found_higher_90:
  leal cells, edx
  xor eax, eax
  movb -2(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb -2(edx, ebx, 2) 
1:
  movb 2(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb 2(edx, ebx, 2)
1:
  movb -20(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb -20(edx, ebx, 2)
1:
  jmp next_cell

mine_found_last:
  leal cells, edx
  xor eax, eax
  movb -2(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb -2(edx, ebx, 2) 
1:
  movb -20(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb -20(edx, ebx, 2)
1:
  jmp next_cell 
  
mine_found_top_right:
  leal cells, edx
  xor eax, eax
  movb -2(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb -2(edx, ebx, 2) 
1:
  movb 20(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb 20(edx, ebx, 2)
1:
  jmp next_cell 

mine_found_bottom_left:
  leal cells, edx
  xor eax, eax
  movb 2(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb 2(edx, ebx, 2)
1:
  movb -20(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb -20(edx, ebx, 2)
1:
  jmp next_cell
 
  
mine_found_left_border:
  leal cells, edx
  xor eax, eax
  movb 2(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb 2(edx, ebx, 2)
1:
  movb 20(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb 20(edx, ebx, 2)
1: 
  movb -20(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb -20(edx, ebx, 2)
1:
  jmp next_cell

mine_found_right_border:
  leal cells, edx
  xor eax, eax 
  movb 20(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb 20(edx, ebx, 2)
1:
  movb -20(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb -20(edx, ebx, 2)
1:
  movb -2(edx, ebx, 2), al
  cmp $1, al
  jz 1f
  incb -2(edx, ebx, 2) 
1:
  jmp next_cell 

next_cell:
  incl ebx
  cmp $99, ebx
  jz finish
  jmp fill_numbers 

finish:
  leave
  ret


main:
  ENTER

  call init_cells
  call print_real_field_text
  call check_field
  call print_newline
  call init_numbers

   //movl $1, cursor_column
  //movl $1, cursor_row
  
  xor eax, eax
loop:
  push eax

  call print_instructions

  push $cursor_column
  push $cursor_row
  call write_cursor_location
  add $8, esp

  push $cursor_column
  push $cursor_row
  call render_field
  add $8, esp
  
  pop eax
  cmp $99, eax
  jz out
  incl eax
  jmp loop

out:
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

real_field_text:
  .asciz "here is real field:"

scanf_separator:
  .asciz "%d %d"

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
