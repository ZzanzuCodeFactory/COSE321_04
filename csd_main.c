#include<stdio.h>

void csd_main() {
//	unsigned char *sw;
	unsigned char *led;
	unsigned char *input_char;
	int iteration_num;
	int i;

	led = (unsigned char *) 0x41200000;
	input_char = (unsigned char *) 0x1000;
//	sw = (unsigned *) 0x41210000;
	iteration_num = (int *) 0x1000000; // ���� �ּ�

//	if(*sw == 0x00) {
//		iteration_num = 350000000;
//	} else if(*sw == 0x01) {
//		iteration_num = 280000000;
//	} else if(*sw >= 0x02 && *sw < 0x04) {
//		iteration_num = 245000000;
//	} else if(*sw >= 0x4 && *sw < 0x08) {
//		iteration_num = 210000000;
//	} else if(*sw >= 0x08 && *sw < 0x10) {
//		iteration_num = 175000000;
//	} else if(*sw >= 0x10 && *sw < 0x20) {
//		iteration_num = 140000000;
//	} else if(*sw >= 0x20 && *sw < 0x40) {
//		iteration_num = 105000000;
//	} else if(*sw >= 0x40 && *sw < 0x80) {
//		iteration_num = 70000000;
//	} else if(*sw >= 0x80) {
//		iteration_num = 35000000;
//	}

	if(*input_char == 49) { // '1'
		iteration_num = 35000000;
	} else if(*input_char == 50) { // '2'
		iteration_num = 70000000;
	} else if(*input_char == 51) { // '3'
		iteration_num = 105000000;
	} else if(*input_char == 52) { // '4'
		iteration_num = 140000000;
	} else if(*input_char == 53) { // '5'
		iteration_num = 175000000;
	} else if(*input_char == 54) { // '6'
		iteration_num = 210000000;
	} else if(*input_char == 55) { // '7'
		iteration_num = 245000000;
	} else if(*input_char == 56) { // '8'
		iteration_num = 350000000;
	} else {
		iteration_num = 350000000;
	}

	*led = 0x01;
	for(i = 0 ; i < iteration_num ; i++);

	*led = 0x02;
	for(i = 0 ; i < iteration_num ; i++);

	*led = 0x04;
	for(i = 0 ; i < iteration_num ; i++);

	*led = 0x08;
	for(i = 0 ; i < iteration_num ; i++);

	*led = 0x10;
	for(i = 0 ; i < iteration_num ; i++);

	*led = 0x20;
	for(i = 0 ; i < iteration_num ; i++);

	*led = 0x40;
	for(i = 0 ; i < iteration_num ; i++);

	*led = 0x80;
	for(i = 0 ; i < iteration_num ; i++);


}
