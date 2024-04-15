#include "../../lib/mylib.h"

.att_syntax noprefix
.global print_newline

print_newline:  // портит только al
  ENTER

  movb newline, al  // кладем в al '\n'
  push eax
  call putchar  // печатаем новую строку
  add $4, esp

  leave
  ret
