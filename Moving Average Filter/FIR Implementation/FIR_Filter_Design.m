fs = 1e3; %Sampling Frequency in Hz
n = 8; %Filter Order
fcut = 150; %Cut off frequency in Hz

%b = fir1(n,fcut/(fs/2)); %Calculate the filter coefficients
b = ones(9,1)/9;

freqz(b,1); %Draw the bode diagram of the filter

b=b*1024; %Multiply the filter coefficients with 1024, as the filter is executed as 10 decimal bits in hardware

disp(b);

