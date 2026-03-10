# Hardware–Software Data Acquisition System for Measuring the Grip Strength in Children



**Manuscript ID:** 10161  

**Journal:** Latin America Transactions  



## Authors

- Raquel Ávila Rodríguez  

- Alejandro Martínez Ramírez  

- Rosa Eréndira Fosado Quiroz  

- Jorge Luis García Ramírez  

 - Universidad Autónoma de San Luis Potosí  



- Javier Ávila Rodríguez  

 - Clínica José Guadalupe, Matehuala S.L.P.



---



## Project Description



This repository contains the hardware, firmware, software interfaces, and experimental data used in the project:



**"Hardware–Software Data Acquisition System for Measuring the Grip Strength in Children."**



The system measures the **grip strength of individual fingers** using **FSR-402 force sensors**. The following fingers are measured:



- Index finger  

- Middle finger  

- Ring finger  

- Pinky finger  



The project integrates:



- Two **data acquisition (DAQ) boards**

- Two **graphical user interfaces**

- Calibration datasets

- Data analysis scripts



Both graphical interfaces can operate with **either DAQ board**.



---



# System Architecture



The system consists of:



### Data Acquisition Boards



1. **PIC-based DAQ board** using the **PIC18F2550 microcontroller**

2. **ESP32-based DAQ board** using the **NODEMCU ESP32S development board**



### Graphical Interfaces



1. **Desktop interface** developed in **LabVIEW**

2. **Mobile interface** developed in **MIT App Inventor**



---



# Repository Structure



## App Inventor



This folder contains the **mobile interface** developed for Android devices using **MIT App Inventor**.



File type:



.aia



The '.aia' file contains the complete design of the mobile application, including:



- Graphical user interface layout  

- Communication blocks  

- Data visualization components  



The application allows users to:



- Monitor finger grip strength measurements  

- Display sensor data in real time  

- Provide a portable interface for field measurements  



---



## Data Bases



This folder contains **Excel files with experimental datasets** used for the **calibration of the sensors**.



The datasets include:



- Applied force values  

- Corresponding sensor voltage readings  

- Experimental measurements used to model the sensor behavior  



These data were used to determine the **third-degree polynomial models** that characterize each sensor.



---



## Firmware



This folder contains the firmware for the two data acquisition boards.



### PIC microcontroller DAQ



Firmware for the acquisition board based on the **PIC18F2550 microcontroller**, responsible for:



- Reading the FSR sensors  

- Performing analog-to-digital conversion  

- Sending measurement data to the graphical interfaces  



### ESP32 NodeMCU DAQ



Firmware for the acquisition board based on the **NODEMCU ESP32S development board**, which performs:



- Sensor signal acquisition  

- Data processing  

- Communication with the graphical interfaces  



---



## Hardware



This folder contains the **electronic schematics** of the data acquisition boards.



### PIC microcontroller DAQ



Schematic design of the acquisition board based on the **PIC18F2550 microcontroller**.



### ESP32 NodeMCU DAQ



Schematic design of the acquisition board based on the **NODEMCU ESP32S development board**.



These schematics describe the connections between:



- Microcontrollers  

- Signal conditioning circuits  

- FSR-402 sensors  

- Communication interfaces  



---



## LabVIEW



This folder contains the **virtual instrument (VI)** developed in **LabVIEW**.



File type:



.vi



The LabVIEW application implements a **desktop interface** that allows:



- Visualization of grip strength measurements  

- Real-time monitoring of the four finger sensors  

- Data acquisition from the DAQ boards  



This interface is intended for **desktop computers or laptops**.



---



## Scripts



This folder contains the scripts used for **sensor calibration analysis**.



The scripts are written in:



Octave / MATLAB (.m)



They are compatible with:



- **GNU Octave (free software)**  

- **MATLAB**



### Purpose of the Scripts



The scripts are used to:



- Determine the **coefficients of third-degree polynomial models** describing the sensor behavior  

- Evaluate the performance of the calibration models using:



&nbsp; - Coefficient of determination (R²)  

&nbsp; - Standard deviation  

&nbsp; - Mean Absolute Error (MAE)  

&nbsp; - Mean Absolute Percentage Error (MAPE)



### Scripts Included



ANALISIS_DANULAR.m  

ANALISIS_DINDICE.m  

ANALISIS_DMEDIO.m  

ANALISIS_DMENIQUE.m  



Each script performs the calibration analysis for one of the four finger sensors. The measured data is already contained in the script text.



---



# Sensors Used



The system uses **FSR-402 force sensitive resistors** to measure the applied finger force.



These sensors are commonly used in:



- Biomechanics  

- Rehabilitation systems  

- Human–machine interaction  





