----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.07.2023 18:13:20
-- Design Name: 
-- Module Name: Recursive_Moving_Average - Behavioral
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
-- Moving avarage filter in recursive implementation with 12 bit signed input and output
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Recursive_Moving_Average is
    Port ( reset : in STD_LOGIC;
           signal_in : in STD_LOGIC_VECTOR (11 downto 0);
           signal_out : out STD_LOGIC_VECTOR (11 downto 0);
           clk : in STD_LOGIC);
end Recursive_Moving_Average;

architecture Behavioral of Recursive_Moving_Average is
type t_delayout is array (0 to 7) of signed(20 downto 0); --delay
signal delayout : t_delayout; --The registers to save the output of the delay elements
signal lastoutput : signed(11 downto 0);

begin
process(clk) is
variable filter_output : signed(20 downto 0);

begin

    if(clk'Event and clk = '1') then --Check for the clock edge
        if(reset = '1') then
            delayout <= (others => (others => '0')); --If there is a reset command, reset all the internal sig
            lastoutput <= (others => '0');
            signal_out <= (others => '0');
            filter_output := (others => '0');
       
        else        
            for i in 0 to 6 loop --Loop over all the delay elements and calculate their next output 
                delayout(i) <= delayout(i+1); --Note: As delayout is a signal it is only r
            end loop;         
            delayout(7)(10 downto 0) <=  signed(signal_in(10 downto 0));  --As there is no previous element, which needs to be added on, treat the first element in the chain seperatly
            
            for i in 11 to 20 loop
                delayout(7)(i) <= signal_in(11);--Extend the number with the carry
            end loop;
            
             --Part of the filter after the delay chain:
            filter_output := signed(signal_in) - delayout(0);
            filter_output := shift_right(signed(filter_output), 3);
            filter_output := filter_output + lastoutput;
            lastoutput <= filter_output(11 downto 0);
        
        --Feed it back to the 12 bit signed output
            signal_out(10 downto 0) <= std_logic_vector(filter_output(10 downto 0));
            signal_out(11) <= filter_output(20); 
        end if;
        
      
    end if;    

end process;

end Behavioral;
