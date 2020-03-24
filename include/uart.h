#ifndef _MBOX_H_
#define _MBOX_H_

#include "gpio.h"



void uart_init();
void uart_send(unsigned int c);
char uart_getc();
void uart_puts(char *s);
void uart_hex(unsigned int d);

#endif
