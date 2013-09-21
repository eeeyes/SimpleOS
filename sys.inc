;useage BOOT_MESSAGE message_label,message_length_constant,message
%macro BOOT_MESSAGE 3

	%1	:	db	%3
	%2	equ	$-%1
%endmacro

%macro START_CALL_PROCO 0
	push ax
	push cx
	push dx
	push es
%endmacro


%macro END_CALL_PROCO 0
	pop es
	pop dx
	pop cx
	pop ax
%endmacro

%macro START_CALLED_PROCO 0
	push bp
	mov bp,sp
	push bx
	push si
	push di
%endmacro


%macro END_CALLED_PROCO 0
	pop di
	pop si
	pop bx
	pop bp
%endmacro


;useage GDT_DES base,limit,attr
;	base:dd
;	limit:dd
;	attr:dw

%macro	GDT_DES 3

	dw %2 & 0xFFFF
	dw %1 & 0xFFFF
	db ( %1 >> 16 ) & 0xFF
	dw ( (%2 >> 8) & 0x0F00 ) | ( %3 & 0xF0FF)
	db ( %1 >> 24 ) & 0xFF
%endmacro

%define CODE_SEG_ATTR 0xC09A
%define DATA_SEG_ATTR 0xC092
