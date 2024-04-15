#include "../lib/mylib.h"

  .att_syntax noprefix
  .global check_field

check_field:  // отображает все поле в открытом виде
  ENTER

  push $0
  push $0
  .set columns, -4
  .set lines, -8 

  xor eax, eax
  xor ebx, ebx
  call print_space  // печатаем space
  call print_space  // печатаем space

numbers_loop_:  // печатаем первую строку цифр
  movb numbers(ebx), al  // кладем в al цифру
  push eax
  call putchar
  add $4, esp
  cmp $9, ebx
  jz numbers_out_

  incl ebx
  call print_space  // печатаем space
  jmp numbers_loop_

numbers_out_:
  call print_newline

  xor ebx, ebx  // счетчик для цифр
loop_:  // печатаем 10 строчек
  xor eax, eax
  xor ecx, ecx

  movb numbers(ebx), al  // кладем в al цифру
  push eax
  call putchar
  add $4, esp
  incl ebx
  call print_space  // печатаем space

  loop2_:  // печатаем колонки

    movl columns(ebp), eax  // смотрим на наш счетчик колонок
    incl eax

    movl lines(ebp), ecx  // смотрим на наш счетчик строк 
    incl ecx
    
    imul ecx, eax 
    mov eax, ecx 
    dec ecx // получаем общее количество итераций (ячеек) в ecx
    
    xor eax, eax
    movb cells(,ecx, 2), al 
    cmp $0, al
    jz store_closed_cell 
    push mine
    jmp print_cell 

store_closed_cell:
    push closed_cell

print_cell:
    call putchar
    add $4, esp
    movl columns(ebp), ecx  // смотрим на наш счетчик 
    cmp $9, ecx
    jz out2_

    incl ecx  // инрементим счетчик
    movl ecx, columns(ebp)

    call print_space
    jmp loop2_

  out2_:
    xor eax, eax
    xor ecx, ecx
    movl ecx, columns(ebp) // обновляем счетчик колонок

    call print_newline

    movl lines(ebp), ecx  // смотрим на наш счетчик 
    cmp $9, ecx
    jz out_

    incl ecx  // инрементим счетчик
    movl ecx, lines(ebp)
    jmp loop_

out_:
  leave
  ret
