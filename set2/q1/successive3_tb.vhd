-- successive3_tb.vhd: Testbench to test the module for detecting a sequence of 3 
-- successive identical inputs

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity successive3_tb is
end successive3_tb;

architecture sim of successive3_tb is

	-- define clock parameters
	constant freq  : integer := 100e6;				-- 100 Mhz clock frequency
	constant cycle : time	 := 1000 ms / freq;		-- 1 clock cycle = 10 ns

	-- declare stimulus and response signals
	signal clk	   : std_logic := '1';
	signal rst 	   : std_logic := '0';
	signal s   	   : std_logic;
	signal y   	   : std_logic;
	signal stream  : std_logic_vector(19 downto 0):= "00011111101011000101";

begin 

	-- instantiate module
	uut : entity work.successive3(moore1) 
		  port map(clk => clk, rst => rst, s => s, y => y);

	-- generate clock signal
	clk <= not clk after cycle/2;

	-- apply stimulus to test uut
	process is 
	begin 

		-- initially hold reset for more than 1 cycle to offset input
		rst <= '1';
		wait for 1.3 * cycle;

		-- then bring uut device out of reset and apply bit stream
		rst <= '0';
		for i in (stream'length-1) downto 0 loop
			s <= '0';
			wait for 0.4*cycle;
			s <= stream(i);
			wait for 0.6*cycle;
		end loop;

		wait;
	end process;

end sim;
