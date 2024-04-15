#include "../../lib/mylib.h"

  .att_syntax noprefix
  .global print_instructions

print_instructions:
  ENTER

  push $instructions 
  call puts 
  add $4, esp

  leave
  ret
