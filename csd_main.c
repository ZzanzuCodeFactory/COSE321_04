#include<stdio.h>

void csd_main() {
	unsigned char *led;
	unsigned char *input_char;
	int iteration_num;
	int i;

	led = (unsigned char *) 0x41200000;
	input_char = (unsigned char *) 0x1000;

	if(*input_char == 49) { // '1'
		iteration_num = 8750000;
	} else if(*input_char == 50) { // '2'
		iteration_num = 17500000;
	} else if(*input_char == 51) { // '3'
		iteration_num = 26250000;
	} else if(*input_char == 52) { // '4'
		iteration_num = 35000000;
	} else if(*input_char == 53) { // '5'
		iteration_num = 43750000;
	} else if(*input_char == 54) { // '6'
		iteration_num = 52500000;
	} else if(*input_char == 55) { // '7'
		iteration_num = 61250000;
	} else if(*input_char == 56) { // '8'
		iteration_num = 87500000;
	} else {
		iteration_num = 87500000;
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
