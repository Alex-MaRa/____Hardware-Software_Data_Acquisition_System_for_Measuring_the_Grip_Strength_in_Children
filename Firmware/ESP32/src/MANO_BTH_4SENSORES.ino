// PROGRAMA QUE CAPTURA CUATRO VARIABLES ANALÓGICAS Y LAS ENVÍA POR EL PUERTO SERIE
// EN EL CUAL SE ENCUENTRA CONECTADO UN MÓDULO CONVERTIDOR A USB QUE LE PERMITE COMUNICARSE
// POR VÍA ALÁMBRICA USB CON LA APLICACIÓN EN LABVIEW DE LA INTERFAZ GRÁFICA
// TAMBIÉN ENVÍA EL CONTENIDO DE LAS VARIABLES A SU MÓDULO DE COMUNICACIONES BLUETOOTH
// LO CUAL LE PERMITE COMUNICARSE VÍA BLUETOOTH CON UNA APP EN UN DISPOSITIVO INTELIGENTE 
// CON SISTEMA OPERATIVO ANDROID, O CON LA APLICACIÓN EN LABVIEW DE LA INTERFAZ GRÁFICA.
//
// DR. ALEJANDRO MARTÍNEZ RAMÍREZ
// INGENIERÍA MECATRÓNICA. UAMRA - UASLP
// LABORATORIO DE INSTRUMENTACIÓN VIRTUAL
// 12 DE NOVIEMBRE 2024
// PROGRAMA ESCRITO PARA EL NODE MCU ESP32
// 

#include "BluetoothSerial.h"
#include "stdio.h"

#if !defined(CONFIG_BT_ENABLED) || !defined(CONFIG_BLUEDROID_ENABLED)
#error Bluetooth is not enabled! Please run `make menuconfig` to and enable it
#endif

BluetoothSerial SerialBT;

int w, x, y, z;      // VARIABLES QUE REPRESENTAN A LAS MEDIDAS DE CUATRO SENSORES
int sensorw = 36;    // SE LE ASIGNA AL PIN DENOMINADO NUMÉRICAMENTE COMO 36 EL NOMBRE sensorw
int sensorx = 39;    // SE LE ASIGNA AL PIN DENOMINADO NUMÉRICAMENTE COMO 39 EL NOMBRE sensorx
int sensory = 34;    // SE LE ASIGNA AL PIN DENOMINADO NUMÉRICAMENTE COMO 34 EL NOMBRE sensory
int sensorz = 35;    // SE LE ASIGNA AL PIN DENOMINADO NUMÉRICAMENTE COMO 35 EL NOMBRE sensorz

void setup()
{
  Serial.begin(115200); // Coloca la velocidad de transmisión en 115200 bps

  SerialBT.begin("ESP32_Mano"); //Identifica al módulo Bluetooth como: ESP32_Mano
  
  pinMode(sensorw, INPUT);
  pinMode(sensorx, INPUT);
  pinMode(sensory, INPUT);
  pinMode(sensorz, INPUT);
  analogReadResolution(10); // SE AJUSTA LA RESOLUCIÓN DEL MÓDULO ADC A 10 BITS
}

void loop()
{
w = analogRead(sensorw)+1000; // Lee la entrada analógica x en el pin 0
x = analogRead(sensorx)+1000; // Lee la entrada analógica x en el pin 0
y = analogRead(sensory)+1000; // Lee la entrada analógica y en el pin 1
z = analogRead(sensorz)+1000; // Lee la entrada analógica z en el pin 2

Serial.print('*'); // envía por puerto serial un identificador antes del 1er número
Serial.print('|'); // envía un caracter '|' como separador
Serial.print(w, DEC); // envía valor del sensor X
Serial.print('|'); // envía un caracter '|' como separador
Serial.print(x, DEC); // envía valor del sensor X
Serial.print('|'); // envía un caracter '|' como separador entre números
Serial.print(y, DEC); // envía valor del sensor Y
Serial.print('|'); // envía un caracter '|' como separador entre números
Serial.print(z, DEC); // envía valor del sensor Z
Serial.println('|'); // envía un caracter '|' como separador entre números

SerialBT.print('*');  // envía por puerto bluetoth un identificador antes del 1er número
SerialBT.print('|'); // envía un caracter '|' como separador
SerialBT.print(w, DEC); // envía valor del sensor X
SerialBT.print('|'); // envía un caracter '|' como separador
SerialBT.print(x, DEC); // envía valor del sensor X
SerialBT.print('|'); // envía un caracter '|' como separador entre números
SerialBT.print(y, DEC); // envía valor del sensor Y
SerialBT.print('|'); // envía un caracter '|' como separador entre números
SerialBT.print(z, DEC); // envía valor del sensor Z
SerialBT.println('|'); // envía un caracter '|' como separador entre números

delay(30); // espera 30 ms para la siguiente lectura
}
