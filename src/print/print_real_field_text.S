#include "../../lib/mylib.h"

  .att_syntax noprefix
  .global print_real_field_text

print_real_field_text:
  ENTER

  push $real_field_text 
  call puts 
  add $4, esp

  leave
  ret
