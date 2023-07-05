----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.06.2023 18:30:59
-- Design Name: 
-- Module Name: Double_Dabble_tb - Behavioral
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
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Double_Dabble_tb is
--The test bench has no input or output signals
end Double_Dabble_tb;

architecture Behavioral of Double_Dabble_tb is

--Declare the component under test, which is the DoubleDabble component
    component DoubleDabble
        port (binary : in std_logic_vector(13 downto 0);
                bcd : out std_logic_vector(15 downto 0));
    end component;
  
 --Declare two signals for input and output. Input is the binary coded number with a maximum of 14 bits. Output is the 4 bit BCD coded equivalent    
 signal input : std_logic_vector(13 downto 0);
 signal output : std_logic_vector(15 downto 0);
    
begin

    UUT: DoubleDabble port map (binary => input, bcd => output);

process 
begin
--The test done here for the Doubble Dabble algorithm is just selecting four numbers and checking them manually.
    input <= "00010011010010";
    wait for 100 ns;
    input <= b"00010011010101";
    wait for 100 ns;
    input <= b"01011011010111";
    wait for 100 ns;
    input <= b"10011001110010";
    wait for 100 ns;
 end process;
end Behavioral;
