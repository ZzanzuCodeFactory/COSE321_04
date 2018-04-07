#define csd_LED_ADDR 0x41200000
#define csd_SWITCH_ADDR 0x41210000
#define csd_SWITCH_INPUT 0x1000000

#include "uart_init.s"
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
	//uart_print // uart 프린트

	//uart_init // uart 초기화

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
	mov r5, #0x1000

loop:


	// check empty: bit#1 is Rx FIFO empty or not (1: empty, 0: not empty)
	ldr r2, [r1]
	and r2, r2, #1<<1
	cmp r2, #0

	// read data and transmit it back to sender, 위의 cmp의 영향을 받음
	ldreq r3, [r0]
	streq r3, [r0]

	//cmp r6, r3 // check wheter the input number has changed. r3-new / r6-old
	//beq csd_main

	cmpeq r3, #13   // 0xD (13) is carriage return in ASCII
	moveq r4, #10 // 0xA (10) is linefeed in ASCII 위의 cmpeq의 영향을 받음
	streq r4, [r0] //  위의 cmpeq의 영향을 받음


	cmp r6, r3
	moveq r6, r3
	streq r6, [r5]
	beq csd_main

	b loop


.data
.align 4
src:

dst:
	.space 16 // allocate memory for 16 words
// Normal Interrupt Service Routine
cydf_irq:
b .
