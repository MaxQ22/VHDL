----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.07.2023 13:23:08
-- Design Name: 
-- Module Name: FIR_Filter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- This entity implements an 8th order transposed low pass filter, designed to run at a sample frequency of 1kHz.
-- The filter uses a signed 12 bit input and output and runs internally on 24 bits signed.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FIR_Filter is
    Port ( reset : in STD_LOGIC; --Active High Reset
           signal_in : in STD_LOGIC_VECTOR (11 downto 0); --12 bit signed input signal
           signal_out : out STD_LOGIC_VECTOR (11 downto 0); --12 bit signed output signal
           clk : in STD_LOGIC); --1kHz clock
end FIR_Filter;

architecture Behavioral of FIR_Filter is
type t_delayout is array (0 to 8) of signed(23 downto 0); --delayout are the registers, which hold the outputs of the delay elements of the filter.
type t_coeffs is array (0 to 8) of signed(11 downto 0); --coeffs are the filter coefficients, multiplied with 1024 (shifted by 10bits) for higher accuracy.

signal input : signed (11 downto 0); --The input signal of the filter
signal delayout : t_delayout; --The registers to save the output of the delay elements
signal coeffs : t_coeffs := (x"FFC",x"008",x"05B",x"0F9",x"14F",x"0F9",x"05B",x"008",x"FFC"); --the filter coefficients as 12 bit two complements multiplied with 1024 (shifted by 10 bits)

begin

   input <= signed(signal_in); --Take the input signal

    
process(clk) is

begin

    if(clk'Event and clk = '1') then --Check for the clock edge
        if(reset = '1') then
            delayout <= (others => (others => '0')); --If there is a reset command, reset all the internal signals to 0
       
        else        
            for i in 0 to 7 loop --Loop over all the delay elements and calculate their next output 
                delayout(i) <= input * coeffs(i) + delayout(i+1); --Note: As delayout is a signal it is only re-loaded at the end of the process, so we still have the old value here, realizing the delay.
            end loop;         
            delayout(8) <= input * coeffs(8);  --As there is no previous element, which needs to be added on for the last element, treat it specially        
        end if;
        
    end if;    

end process;

signal_out(10 downto 0) <= std_logic_vector(delayout(0)(20 downto 10)); --Shift the output by 10 bits to the right. Need to divide by 1024, as the coefficients are multiplied by 1024 for better filter accuracy.
signal_out(11) <= delayout(0)(23); --Carry over the sign bit

end Behavioral;
