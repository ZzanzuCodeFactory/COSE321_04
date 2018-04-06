
.data
string:
	.ascii "----------- LED On Period ----------\n"
	.ascii "1. 100ms 2. 200ms 3. 300ms 4. 400 ms\n"
	.ascii "5. 500ms 6. 600ms 7. 700ms 8. 1 sec \n"
	.ascii "------------------------------------\n"
	.ascii "Select:"
	.byte 0x0D
	.byte 0x00

.text

.macro uart_print

	bl uart_trans

.endm


#include "uart_regs.h"

uart_trans:

//////////////////////////////////////////////
//       아래에 오류 발생 시 clean project  //
//////////////////////////////////////////////

	ldr 	r0, =UART1_BASE @ regs파일에 설정되어있음
	ldr 	r1, =string

TRANSMIT_loop:

	// ---------  Check to see if the Tx FIFO is empty ------------------------------
	ldr r2, [r0, #UART_CHANNEL_STS_REG0_OFFSET]	//@ get Channel Status Register
	and	r2, r2, #0x8		@ get Transmit Buffer Empty bit(bit[3:3])
	cmp	r2, #0x8				@ check if TxFIFO is empty and ready to receive new data tx버퍼가 비었는지 확인
	bne	TRANSMIT_loop		@ if TxFIFO is NOT empty, keep checking until it is empty
	//------------------------------------------------------------------------------

	ldrb    r3, [r1], #1 //@ 먼저 읽어오고 1증가 ㅡ 다음 문자 읽어올 수 있도록
	streqb	r3, [r0, #UART_TX_RX_FIFO0_OFFSET]	//@ fill the TxFIFO with 0x48 읽어온 문자를 보냄
	cmp      r3, #0x00 @ 다 보냈다면.
	bne		TRANSMIT_loop

	mov		pc, lr				@    return to the caller
