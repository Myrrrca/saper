#include "../lib/mylib.h"

  .global write_cursor_location
  .att_syntax noprefix

write_cursor_location:
  ENTER
  XORALL

  .set cursor_row, 8
  .set cursor_column, 12
  movl cursor_row(ebp), eax 
  movl cursor_column(ebp), ecx 
  push eax
  push ecx
  push $scanf_separator
  call scanf
  add $12, esp

  leave
  ret
