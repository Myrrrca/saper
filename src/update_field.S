#include "../lib/mylib.h"
  .att_syntax noprefix
  .global update_field

update_field:
  ENTER
  XORALL

  
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
  jz game_lost
  cmp $48, cl
  jnz do_nothing  // открыли не 0 
  cmp $0, eax
  jz opened_first_cell
  cmp $9, eax
  jz opened_top_right
  cmp $10, eax
  jbe opened_first_row
  cmp $90, eax
  jge opened_last_row
  cmp $99, eax
  jz opened_last_cell
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
  xor ebx, ebx
  movb 3(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, 3(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  incl ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  decl ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
  movb $1, 3(edx, eax, 2)
1:
  movb -2(edx, eax, 2), cl  // ecx -- значение левой клетки
  cmp $1, ecx
  jz 1f
  xor ebx, ebx
  movb -1(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, -1(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  decl ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  incl ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
   movb $1, -1(edx, eax, 2)
1:
  movb 20(edx, eax, 2), cl  // ecx -- значение нижней клетки
  cmp $1, ecx
  jz 1f
  xor ebx, ebx
  movb 21(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, 21(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  addl $10, ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  subl $10, ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
  movb $1, 21(edx, eax, 2)
1:
  movb -20(edx, eax, 2), cl  // ecx -- значение верхней клетки
  cmp $1, ecx
  jz 1f
  xor ebx, ebx
  movb -19(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, -19(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  subl $10, ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  addl $10, ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
  movb $1, -19(edx, eax, 2)
1:
  jmp do_nothing

opened_first_cell:
  leal cells, edx
  xor ecx, ecx
  movb 2(edx, eax, 2), cl  // ecx -- значение правой клетки
  cmp $1, ecx
  jz 1f
  xor ebx, ebx
  movb 3(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, 3(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  incl ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  decl ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
  movb $1, 3(edx, eax, 2)
1:
  movb 20(edx, eax, 2), cl  // ecx -- значение нижей клетки
  cmp $1, ecx
  jz 1f
  xor ebx, ebx
  movb 21(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, 21(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  addl $10, ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  subl $10, ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
  movb $1, 21(edx, eax, 2)
1:
  jmp do_nothing

opened_first_row:
  leal cells, edx
  xor ecx, ecx
  movb 2(edx, eax, 2), cl  // ecx -- значение правой клетки
  cmp $1, ecx
  jz 1f
  xor ebx, ebx
  movb 3(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, 3(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  incl ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  decl ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
  movb $1, 3(edx, eax, 2)
1:
  movb -2(edx, eax, 2), cl  // ecx -- значение левой клетки
  cmp $1, ecx
  jz 1f
  xor ebx, ebx
  movb -1(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, -1(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  decl ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  incl ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
  movb $1, -1(edx, eax, 2)
1:
  movb 20(edx, eax, 2), cl  // ecx -- значение нижней клетки
  cmp $1, ecx
  jz 1f
  xor ebx, ebx
  movb 21(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, 21(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  addl $10, ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  subl $10, ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
  movb $1, 21(edx, eax, 2)
1:
  jmp do_nothing

opened_last_row:
  leal cells, edx
  xor ecx, ecx
  movb 2(edx, eax, 2), cl  // ecx -- значение правой клетки
  cmp $1, ecx
  jz 1f
  xor ebx, ebx
  movb 3(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, 3(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  incl ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  decl ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
  movb $1, 3(edx, eax, 2)
1:
  movb -2(edx, eax, 2), cl  // ecx -- значение левой клетки
  cmp $1, ecx
  jz 1f
  xor ebx, ebx
  movb -1(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, -1(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  decl ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  incl ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
  movb $1, -1(edx, eax, 2)
1:
  movb -20(edx, eax, 2), cl  // ecx -- значение верхней клетки
  cmp $1, ecx
  jz 1f
  xor ebx, ebx
  movb -19(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, -19(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  subl $10, ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  addl $10, ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
  movb $1, -19(edx, eax, 2)
1:
  jmp do_nothing

opened_last_cell:
  leal cells, edx
  xor ecx, ecx
  movb -2(edx, eax, 2), cl  // ecx -- значение левой клетки
  cmp $1, ecx
  jz 1f
  xor ebx, ebx
  movb -1(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, -1(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  decl ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  incl ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
  movb $1, -1(edx, eax, 2)
1:
  movb -20(edx, eax, 2), cl  // ecx -- значение верхней клетки
  cmp $1, ecx
  jz 1f
  xor ebx, ebx
  movb -19(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, -19(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  subl $10, ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  addl $10, ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
  movb $1, -19(edx, eax, 2)
1:
  jmp do_nothing

opened_top_right:
  leal cells, edx
  xor ecx, ecx
  movb -2(edx, eax, 2), cl  // ecx -- значение левой клетки
  cmp $1, ecx
  jz 1f
  xor ebx, ebx
  movb -1(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, -1(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  decl ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  incl ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
  movb $1, -1(edx, eax, 2)
1:
  movb 20(edx, eax, 2), cl  // ecx -- значение нижней клетки
  cmp $1, ecx
  jz 1f
  xor ebx, ebx
  movb 21(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, 21(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  addl $10, ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  subl $10, ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
  movb $1, 21(edx, eax, 2)
1:
  jmp do_nothing

opened_bottom_left:
  leal cells, edx
  xor ecx, ecx
  movb 2(edx, eax, 2), cl  // ecx -- значение правой клетки
  cmp $1, ecx
  jz 1f
  xor ebx, ebx
  movb 3(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, 3(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  incl ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  decl ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
  movb $1, 3(edx, eax, 2)
1:
  movb -20(edx, eax, 2), cl  // ecx -- значение верхней клетки
  cmp $1, ecx
  jz 1f
  xor ebx, ebx
  movb -19(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, -19(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  subl $10, ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  addl $10, ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
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
  xor ebx, ebx
  movb 3(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, 3(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  incl ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  decl ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
  movb $1, 3(edx, eax, 2)
1:
  movb 20(edx, eax, 2), cl  // ecx -- значение нижней клетки
  cmp $1, ecx
  jz 1f
  xor ebx, ebx
  movb 21(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, 21(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  addl $10, ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  subl $10, ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
  movb $1, 21(edx, eax, 2)
1:
  movb -20(edx, eax, 2), cl  // ecx -- значение верхней клетки
  cmp $1, ecx
  jz 1f
  xor ebx, ebx
  movb -19(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, -19(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  subl $10, ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  addl $10, ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
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
  xor ebx, ebx
  movb -1(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, -1(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  decl ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  incl ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
  movb $1, -1(edx, eax, 2)
1:
  movb 20(edx, eax, 2), cl  // ecx -- значение нижней клетки
  cmp $1, ecx
  jz 1f
  xor ebx, ebx
  movb 21(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, 21(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  addl $10, ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  subl $10, ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
  movb $1, 21(edx, eax, 2)
1:
  movb -20(edx, eax, 2), cl  // ecx -- значение верхней клетки
  cmp $1, ecx
  jz 1f
  xor ebx, ebx
  movb -19(edx, eax, 2), bl
  cmp $1, ebx 
  jz 1f
  cmp $48, ecx
  jnz 2f
  movb $1, -19(edx, eax, 2)

  PUSHA 
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  subl $10, ecx
  movl ecx, (edx)
  push edx
  movl cursor_row(ebp), edx 
  push edx
  call update_field
  add $8, esp
  movl cursor_column(ebp), edx 
  movl (edx), ecx
  addl $10, ecx
  movl ecx, (edx)
  POPA
  jmp 1f

2:
  movb $1, -19(edx, eax, 2)
1:
  jmp do_nothing
  

do_nothing:

  leave
  ret


game_lost:
  push $cursor_column
  push $cursor_row
  call render_field
  add $8, esp

  push $lose_text
  call puts
  add $4, esp

  XORALL
  mov $0, ebx
  mov $1, eax
  int $0x80
  

  leave
  ret
