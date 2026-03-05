//-------------------------------------------------------------------------
// Programa que realiza el sensado de cuatro sensores FSR 402
// y los transmite mediante comunicación USB y Bluetooth 
// Programa implantado en el mirocontrolador PIC18F2550
//-------------------------------------------------------------------------
#include <18F2550.h>
#fuses HSPLL, NOWDT, NOPROTECT, NOLVP, NODEBUG, USBDIV, PLL5, CPUDIV1, VREGEN
#device adc=10
#use delay(clock=48000000)
#use rs232(baud=9600, xmit=pin_C6, rcv=pin_C7, bits=8)
#include <usb_cdc.h>
#include <usb_desc_cdc_alex.h>
#include <math.h>
void main() {
   int16 q,q0,q1,q2,q3;
   q1=0;
   usb_cdc_init();
   usb_init();
   while (!usb_cdc_connected()) {}
   usb_task();
   while (!usb_enumerated()) {}
   setup_adc_ports(ALL_ANALOG);
   setup_adc(ADC_CLOCK_INTERNAL);
   set_adc_channel(0);
    do {
      delay_ms(50);
      set_adc_channel(0);
      delay_us(80);
      q = read_adc();
      delay_us(500);
      q0 = q*1+1000;
      set_adc_channel(1);
      delay_us(80);      
      q = read_adc();
      delay_us(500);      
      q1 = q*1+1000;      
      set_adc_channel(2);
      delay_us(80);      
      q = read_adc();
      delay_us(500);      
      q2 = q*1+1000;      
      set_adc_channel(3);
      delay_us(80);      
      q = read_adc();
      delay_us(500);      
      q3 = q*1+1000;      
      printf("*|%Lu|%Lu|%Lu|%Lu|\n",q0,q1,q2,q3);
    printf(usb_cdc_putc,"*|%Lu|%Lu|%Lu|%Lu|\n",q0,q1,q2,q3);
   } while (TRUE);
}
