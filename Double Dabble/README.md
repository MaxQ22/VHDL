# Double Dabble

## Description
The Doubble Dabble algorithm is an algorithm to convert a binary coded number to a BCD coded number, for example to display it on a 7-segment display.
This DoubleDabble entity, implements this algorithm for a four digit number.
The input signal "binary" is the 14 bit binary representation of the number, while the 4 byte output signal "bcd" is the corresponding BCD representation.

## Usage
The Repository includes two files, one is the source file of the Doubble Dabble entity, the other one is a test bench, which uses four number, which can be checked for in a VHDL simulator to test the Doubble Dabble algorithm. The numbers in the test bench, that are used for testing are 1234, 1237, 5847 and 9842. 

When running the simulation, the following result is expected. Note, that both signals are shown in hexadecimal radix, but as the output is a BCD representation, it appears as if it is a decimal number.

 ![Simulation Screenshot](/Simulation_Result.PNG)


























