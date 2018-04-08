#define csd_LED_ADDR 0x41200000
#define csd_SWITCH_ADDR 0x41210000
#define csd_SWITCH_INPUT 0x1000000
#define store_input 0x00001000

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
	uart_print // uart 프린트

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
	mov r7, #0x1000

loop:
	// check empty: bit#1 is Rx FIFO empty or not (1: empty, 0: not empty)
	ldr r2, [r1]
	and r2, r2, #1<<1
	cmp r2, #0

	// read data and transmit it back to sender, 위의 cmp의 영향을 받음
	ldreq r8, [r0]
	streq r8, [r0]

	//cmp r6, r3 // check wheter the input number has changed. r3-new / r6-old
	//beq csd_main

	cmpeq r8, #13   // 0xD (13) is carriage return in ASCII
	moveq r4, #10 // 0xA (10) is linefeed in ASCII 위의 cmpeq의 영향을 받음
	streq r4, [r0] //  위의 cmpeq의 영향을 받음

	ldr r5, [r7]
	cmp r5, r8 // r6 -> r3? ㄴㄴ r3는 루프 한번돌고 오면 전혀 다른 놈되어잇음/ 새로 입력햇을댄 r3랑 비교하는게 맞는데 입력 없을댄 r6랑 비교하는게 맞고...하...
	beq loop2

	mov r6, r8
	str r6, [r7]
	bl csd_main

	b loop

loop2:
	bl csd_main
	b loop

.data
.align 4
src:

dst:
	.space 16 // allocate memory for 16 words
// Normal Interrupt Service Routine
cydf_irq:
b .
