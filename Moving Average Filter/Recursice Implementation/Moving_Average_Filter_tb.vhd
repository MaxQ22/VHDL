----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.07.2023 17:16:07
-- Design Name: 
-- Module Name: FIR_Filter_tb - Behavioral
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
use STD.textio.all;
use IEEE.NUMERIC_STD.ALL;


entity Recursive_Moving_Average_tb is
--  Port ( );
end Recursive_Moving_Average_tb;

architecture Behavioral of Recursive_Moving_Average_tb is
--Declare the Recursive_Moving_Average component, as component under test
component Recursive_Moving_Average
    Port ( reset : in STD_LOGIC;
           signal_in : in STD_LOGIC_VECTOR (11 downto 0);
           signal_out : out STD_LOGIC_VECTOR (11 downto 0);
           clk : in STD_LOGIC);
end component;

--Declare signals as input and output of the component under test and map them to the component under test
signal clk : std_logic;
signal input : std_logic_vector(11 downto 0);
signal output : std_logic_vector(11 downto 0);
signal reset : std_logic;
begin
UUT: Recursive_Moving_Average port map (reset => reset, signal_in => input, signal_out => output, clk => clk);

--start the test
process
-- The test vectors are read from a file, that is written by the Simulink simulation
  file text_file : text open read_mode is "/TestData.csv";
  variable text_line : line;
  variable ok : boolean;
  variable char : character;
  variable time : integer;
  variable lasttime : integer;
  variable signalin : integer;
  variable signalout : integer;
  
  begin
    -- Reset the Filter, to habe good starting conditions:
    lasttime := 0;
    input <= x"000";
    clk <= '0';
    reset <= '1';
    wait for 500us;
    clk <= '1';
    wait for 500us;
    clk <= '0';
    reset <='0';
    
    --Start reading the csv file, which contains the test vectors.
    while not endfile(text_file) loop
     
      readline(text_file, text_line);
     
      -- Skip empty lines and single-line comments
      if text_line.all'length = 0 or text_line.all(1) = '#' then
        next;
      end if;
      
      --Read the time of the current sample from the CSV file
      read(text_line, time, ok);
      assert ok report "Read 'wait_time' failed for line: " & text_line.all severity failure;
      
      --Read the comma from the CSV file
       read(text_line, char, ok);
       assert ok report "Read 'wait_time' failed for line: " & text_line.all severity failure;
    
      --Read the input signal from the CSV file
      read(text_line, signalin, ok);
      assert ok report "Read 'wait_time' failed for line: " & text_line.all severity failure;
    
      --Route the input signal to the component under test
      input <= std_logic_vector(to_unsigned(signalin, input'length));
      
      --Wait for half of the time between the current and next sample. The sample have the same frequency as the sample rate of the filter.
      wait for (time-lasttime)*0.5us;
      clk<='1'; --After half of the time, set the clock to high, promting the filter to execute. NOTE: this adds half a clock cycle of dead time to the filter dynamic
      wait for (time-lasttime)*0.5us; --Wait for the rest half of the sample time
      clk<='0';
      
      lasttime := time; --Remeber the last time to calculate the wait time based in the difference between the current and last time.
 
    end loop;
    
    end process;
end Behavioral;


