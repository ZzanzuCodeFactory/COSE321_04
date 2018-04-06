#define csd_LED_ADDR 0x41200000
#define csd_SWITCH_ADDR 0x41210000
#define csd_SWITCH_INPUT 0x1000000

#include "uart_init.s"
#include "uart_print.s"

.extern csd_main
.align 8
// Our interrupt vector table
cydf_entry:
	b csd_reset
	b .
	b .
	b .
	b .
	b .
	b cydf_irq
	b .
.global main
csd_reset:

main:

	uart_init // uart 초기화

	uart_print // uart 프린트

loop:

	bl csd_main @ r3 = iteration_num
	mov r5, r3

	ldr r3, =csd_LED_ADDR

	mov r4, r5 @ r4 : iteration number which will be decreased by 1
	mov r2, #1 @ LED0
	str r2, [r3]

	led0:
		sub r4, #1
		cmp r4, #0
		bne led0

	mov r4, r5
	mov r2, #2 @ LED1
	str r2, [r3]

	led1:
		sub r4, #1
		cmp r4, #0
		bne led1

	mov r4, r5
	mov r2, #4 @ LED2
	str r2, [r3]

	led2:
		sub r4, #1
		cmp r4, #0
		bne led2

	mov r4, r5
	mov r2, #8 @ LED3
	str r2, [r3]

	led3:
		sub r4, #1
		cmp r4, #0
		bne led3

	mov r4, r5
	mov r2, #16 @ LED4
	str r2, [r3]

	led4:
		sub r4, #1
		cmp r4, #0
		bne led4

	mov r4, r5
	mov r2, #32 @ LED5
	str r2, [r3]

	led5:
		sub r4, #1
		cmp r4, #0
		bne led5

	mov r4, r5
	mov r2, #64 @ LED6
	str r2, [r3]

	led6:
		sub r4, #1
		cmp r4, #0
		bne led6

	mov r4, r5
	mov r2, #128 @ LED7
	str r2, [r3]

	led7:
		sub r4, #1
		cmp r4, #0
		bne led7

	@mov r4, r5
	@mov r2, #256 @ LED8
	@str r2, [r3]

	b loop
forever:
	nop
	b forever
.data
.align 4
src:

dst:
	.space 16 // allocate memory for 16 words
// Normal Interrupt Service Routine
cydf_irq:
b .
