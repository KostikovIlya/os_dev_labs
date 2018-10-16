.text
.global _start
_start:
	.code16

    # disable interrupts
    cli
    mov $500, %ax
    mov %ax, %sp
    jmp loop_print_time

loop_print_time:

	call suppress_cursor

	movw $0x04 , %ax
	call read_rtc_register
	call PRINT_BCD_FROM_AL
	
	call PRINT_COL
	
	movw $0x02 , %ax
	call read_rtc_register
	call PRINT_BCD_FROM_AL
	
	call PRINT_COL
	
	movw $0x00 , %ax
	call read_rtc_register
	
	call PRINT_BCD_FROM_AL
	
	#movb $0x0, %ah
	#pushw %ax
    #call PRINT_INT
    ## clean stack of arg (CDECL)
    #add $2, %sp
    
    movb $0x0e , %ah
    movb $0x0D , %al
    int $0x10
    call DELAY
	jmp loop_print_time
	
read_rtc_register:
	out %al , $0x70
	inb $0x71 , %al
	ret
	
suppress_cursor:
	movb $0x01, %ah
	movb $0, %cl
	movb $0x20, %ch
	int $0x10
	ret
	
PRINT_BCD_FROM_AL:
	movb %al, %dl
	shrb $4, %al 
	addb $'0', %al
	movb $0x0e, %ah
	int $0x10
	
	movb %dl, %al
	andb $0x0F ,%al 
	addb $'0', %al
	movb $0x0e, %ah
	int $0x10
	
	ret

PRINT_COL:
	movb $0x0e, %ah
	movb $':', %al
	int $0x10
	ret

DELAY:
	mov $0x0af0, %di  
.delay1:

	mov  $0xffff, %si 
.delay2:
    dec %si
    nop
    jnz .delay2
    
    dec %di
    nop
    jnz .delay1
    
    ret

	
#.bss
# .space 128
#STACK:

#.fill 510 -(. - STACK) , 1, 0
#.fill 510 - (. - _start), 0    /*Zerofill up to 510 bytes */
. = 510
.word 0xAA55       /*Boot Sector signature*/





