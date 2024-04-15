#include "../../lib/mylib.h"
  .att_syntax noprefix
  .global print_space

print_space:  // портит только al
  ENTER

  movb space, al  // кладем в al space 
  push eax
  call putchar
  add $4, esp
  
  leave
  ret
