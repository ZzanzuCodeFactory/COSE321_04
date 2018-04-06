#include<stdio.h>

void csd_main() {
	unsigned char *sw;
	int iteration_num;

	printf("Console test");

	sw = (unsigned *) 0x41210000;
	iteration_num = (int *) 0x1000000; // 임의 주소

	if(*sw == 0x00) {
		iteration_num = 350000000;
	} else if(*sw == 0x01) {
		iteration_num = 280000000;
	} else if(*sw >= 0x02 && *sw < 0x04) {
		iteration_num = 245000000;
	} else if(*sw >= 0x4 && *sw < 0x08) {
		iteration_num = 210000000;
	} else if(*sw >= 0x08 && *sw < 0x10) {
		iteration_num = 175000000;
	} else if(*sw >= 0x10 && *sw < 0x20) {
		iteration_num = 140000000;
	} else if(*sw >= 0x20 && *sw < 0x40) {
		iteration_num = 105000000;
	} else if(*sw >= 0x40 && *sw < 0x80) {
		iteration_num = 70000000;
	} else if(*sw >= 0x80) {
		iteration_num = 35000000;
	}
}
