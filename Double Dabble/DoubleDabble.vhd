----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.06.2023 18:20:04
-- Design Name: 
-- Module Name: DoubleDabble - Behavioral
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
-- The Doubble Dabble algorithm is an algorithm to convert a binary coded number to a BCD coded number, for example to display it on a 7-segment display.
-- This DoubleDabble entity, implements this algorithm for a four digit number.
--The input signal "binary" is the 14 bit binary representation of the number, while the 4 byte output signal "bcd" is the corresponding BCD representation.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DoubleDabble is
    Port ( binary : in STD_LOGIC_VECTOR (13 downto 0);
           bcd : out STD_LOGIC_VECTOR (15 downto 0));
end DoubleDabble;

architecture Behavioral of DoubleDabble is
  
begin

process(binary) --Double Dabble Algorithm for binary to BCD conversion
    variable digits : unsigned (15 downto 0);  --Variable to hold the working version of the BCD digits
    begin
 
            digits := x"0000"; --Initialize digits to all 0 in the beginning
            for i in 13 downto 0 loop
                --Check, if any of the 4 bytes of the BCD representation is bigger or equal to 4. In this case, 3 needs to be added.
                if(digits(3 downto 0) >= 5) then
                    digits(3 downto 0) := digits(3 downto 0) + 3;
                 end if;
                 if(digits(7 downto 4) >= 5) then
                    digits(7 downto 4) := digits(7 downto 4) + 3;
                 end if;
                 if(digits(11 downto 8) >= 5) then
                    digits(11 downto 8) := digits(11 downto 8) + 3;
                 end if;
                 if(digits(13 downto 12) >= 5) then
                    digits(13 downto 12) := digits(13 downto 12) + 3;
                 end if;
                --Shift the BCD digits and shift in the next bit of the binary representation
                digits := shift_left(digits, 1);
                digits(0) := binary(i);
            end loop;
             bcd <= std_logic_vector(digits); --Prepare the output signal
    end process;

end Behavioral;
