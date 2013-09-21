%include "sys.inc"
%include "auto.inc"

BOOTSEG			equ	0x7c0
SYSSEG			equ 	0x1000
	
	jmp BOOTSEG:go
go:
	mov ax,cs
	mov ds,ax

	mov es,ax

	mov ss,ax
	mov sp,0x400

	START_CALL_PROCO
	call LoadSystem
	END_CALL_PROCO

	START_CALL_PROCO
	call ClearScreen
	END_CALL_PROCO

	START_CALL_PROCO
	push word 0x0100;
	push word BootMessageLength
	push word BootMessage
	push ds
	call DispStr
	END_CALL_PROCO


	cli
	mov ax,SYSSEG
	mov ds,ax

	xor ax,ax
	mov es,ax
	mov cx,SYS_LEN_BYTES/2
	sub si,si
	sub di,di
	rep movsw

	mov ax,cs
	mov ds,ax

	lgdt [GDT_48]
	
	mov ax,0x1
	lmsw ax
	jmp dword 8:0
LoadSystem:
	START_CALLED_PROCO

	mov ax,SYSSEG
	mov es,ax
	xor bx,bx
	
	mov dx,0x0
	mov cx,0x2

	mov ax,0x0200+SYS_LEN_SECTORS
	int 0x13
	jnc ok_load
	jmp $
ok_load:END_CALLED_PROCO
	ret

ClearScreen:
	START_CALLED_PROCO

	mov ax,0x0600
	mov cx,0
	mov dx,0x184f
	int 10h

	END_CALLED_PROCO
	ret
DispStr:
	START_CALLED_PROCO

	mov ax,[bp+4];
	mov es,ax

	mov ax,[bp+6];BootMessage

	mov bx,bp
	mov bp,ax

	mov cx,[bx+8];BootMessageLength
	mov dx,[bx+10]

	mov ax,0x1301
	mov bx,0x000c

	int 10h
	
	END_CALLED_PROCO
	ret
BOOT_MESSAGE	 BootMessage,	BootMessageLength,	%[MESSAGE]	
GDT_LABEL:
	GDT_DES 0,0,0
	GDT_DES 0,0x07FF,CODE_SEG_ATTR
	GDT_DES 0,0x07FF,DATA_SEG_ATTR
GDT_LEN		equ		$-GDT_LABEL
GDT_48:		dw		GDT_LEN - 1
		dd		( BOOTSEG<<4 ) + GDT_LABEL
	
times 510 - ($-$$)	db	0
dw 0xaa55
