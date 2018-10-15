.text
.global _start
_start:
	.code16

    # disable interrupts
    cli
    jmp loop_print_symbol

loop_print_symbol:
	movb $'X' , %al       #character to print
    movb $0x0e, %ah       #bios service code to print
    int  $0x10            #interrupt the cpu now
	jmp loop_print_symbol

#.fill 510 -(. - _start) , 1, 0
#.fill 510 - (. - _start), 0    /*Zerofill up to 510 bytes */
. = 510
.word 0xAA55       /*Boot Sector signature*/





