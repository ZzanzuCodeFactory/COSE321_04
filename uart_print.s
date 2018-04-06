
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
//       �Ʒ��� ���� �߻� �� clean project  //
//////////////////////////////////////////////

	ldr 	r0, =UART1_BASE @ regs���Ͽ� �����Ǿ�����
	ldr 	r1, =string

TRANSMIT_loop:

	// ---------  Check to see if the Tx FIFO is empty ------------------------------
	ldr r2, [r0, #UART_CHANNEL_STS_REG0_OFFSET]	//@ get Channel Status Register
	and	r2, r2, #0x8		@ get Transmit Buffer Empty bit(bit[3:3])
	cmp	r2, #0x8				@ check if TxFIFO is empty and ready to receive new data tx���۰� ������� Ȯ��
	bne	TRANSMIT_loop		@ if TxFIFO is NOT empty, keep checking until it is empty
	//------------------------------------------------------------------------------

	ldrb    r3, [r1], #1 //@ ���� �о���� 1���� �� ���� ���� �о�� �� �ֵ���
	streqb	r3, [r0, #UART_TX_RX_FIFO0_OFFSET]	//@ fill the TxFIFO with 0x48 �о�� ���ڸ� ����
	cmp      r3, #0x00 @ �� ���´ٸ�.
	bne		TRANSMIT_loop

	mov		pc, lr				@    return to the caller
