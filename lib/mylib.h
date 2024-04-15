#pragma ones

.macro ENTER
  push ebp
  mov esp, ebp
.endm

.macro LEAVE
  mov ebp, esp
  pop ebp
.endm

.macro XORALL
  xor eax, eax
  xor ebx, ebx
  xor ecx, ecx
  xor edx, edx
.endm

