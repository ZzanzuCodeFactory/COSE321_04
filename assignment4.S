#define csd_LED_ADDR 0x41200000
#define csd_SWITCH_ADDR 0x41210000
#define csd_SWITCH_INPUT 0x1000000
#define store_input 0x00001000

#include "uart_print.s"
#include "uart_regs.h"

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
	// print menu
	uart_print

	ldr r0,	=slcr_UART_RST_CTRL
	ldr r1, =0x0	//	reset UART
	str r1, [r0]

	ldr r0, =slcr_UART_CLK_CTRL
	ldr r1, =0x1402	// divisor = 0x14 (ref clk = 50MHz), srcsel = 0, CLKACT1 = true, CLKACT0 = false
	str r1, [r0]

	ldr r0, =uart_mode_reg0
	ldr r1, =0x20
	str r1, [r0]

	ldr r0, =uart_Control_reg0
	ldr r1, =0x28	//uart off
	str r1, [r0]

	ldr r0, =uart_Baud_rate_gen_reg0
	ldr r1, =0x3e
	str r1, [r0]

	ldr r0, =uart_Baud_rate_divider_reg0
	ldr r1, =0x6
	str r1, [r0]

	ldr r0, =uart_Control_reg0
	ldr r1, =0x00000117	//uart start
	str r1, [r0]

	ldr r0, =uart_Modem_ctrl_reg0
	ldr r1, [r0]

	ldr r0, =uart_Modem_sts_reg0
	ldr r1, [r0]

	ldr r0, =uart_TX_RX_FIFO0
	ldr r1, =uart_Channel_sts_reg0

	// create address for the input number(1~8)
	mov r7, #0x1000

loop:
	// check empty: bit#1 is Rx FIFO empty or not (1: empty, 0: not empty)
	ldr r2, [r1]
	and r2, r2, #1<<1
	cmp r2, #0

	// read data and transmit it back to sender
	ldreq r8, [r0]
	streq r8, [r0]

	cmpeq r8, #13   // 0xD (13) is carriage return in ASCII
	moveq r4, #10 // 0xA (10) is linefeed in ASCII
	streq r4, [r0]

	ldr r5, [r7] 				// load the existing data
	cmp r5, r8 					// compare with new data
	beq loop_with_same_speed	// if there's no change, then just turn on led with same speed

	mov r6, r8					// if there's change, then get the new data
	str r6, [r7]				// and send it to C code which turns on the led.
	bl csd_main

	b loop

loop_with_same_speed:
	bl csd_main
	b loop

.data
.align 4
src:

dst:
	.space 16

cydf_irq:
b .
