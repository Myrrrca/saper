.macro ENTER
  push ebp
  mov esp, ebp
.endm

.macro LEAVE
  mov ebp, esp
  pop ebp
.endm


