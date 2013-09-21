%include "auto.inc"
%include "sys.inc"
global _start
extern main
[BITS 32]
_start:
	mov ax,0x10
	mov ds,ax

	lss  esp,[_init_stack]
	call main
	jmp $
times 1024 db 0
_init_stack:
	dd _init_stack
	dw 0x10
  
