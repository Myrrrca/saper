#include "../lib/mylib.h"

  .att_syntax noprefix
  .global render_field
  
render_field:
  ENTER

  push $0
  push $0
  .set columns, -4
  .set lines, -8 

  xor eax, eax
  xor ebx, ebx
  call print_space  // печатаем space
  call print_space  // печатаем space

numbers_loop:
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

  xor ebx, ebx
loop:
  xor eax, eax
  xor ecx, ecx

  movb numbers(ebx), al  // кладем в al цифру
  push eax
  call putchar
  add $4, esp
  incl ebx
  call print_space  // печатаем space

  loop2:  // печатаем колонки
    movb closed_cell, al  // кладем в al '#'
    push eax
    call putchar
    add $4, esp
    movl columns(ebp), ecx  // смотрим на наш счетчик 
    cmp $9, ecx
    jz out2

    incl ecx  // инрементим счетчик
    movl ecx, columns(ebp)

    call print_space
    jmp loop2

  out2:
    xor eax, eax
    xor ecx, ecx
    movl ecx, columns(ebp) // обновляем счетчик колонок

    call print_newline

    movl lines(ebp), ecx  // смотрим на наш счетчик 
    cmp $9, ecx
    jz out

    incl ecx  // инрементим счетчик
    movl ecx, lines(ebp)
    jmp loop

out:
  leave
  ret
