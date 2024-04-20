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

.macro PUSHA
  push eax
  push ebx
  push ecx
  push edx
.endm

.macro POPA
  pop edx
  pop ecx
  pop ebx
  pop eax
.endm
