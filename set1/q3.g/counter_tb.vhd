-- counter_tb.vhd: Testbench to test the 4-bit unsigned up counter with async clear

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_tb is
end counter_tb;

architecture sim of counter_tb is
	constant cycle : time	   := 10 ns;
	signal   clock : std_logic := '1';
	signal   clear : std_logic := '1';
	signal   count : unsigned(3 downto 0);
begin
	uut : entity work.counter(rtl)
	      port map(clock => clock, clear => clear, count => count);
	clock <= not clock after cycle/2;
	process begin
		wait for 0.3*cycle;
		clear <= '0';
		wait for 5*cycle;
		clear <= '1';
		wait for 1.3*cycle;
		clear <= '0';
		wait for 5*cycle;
		wait;
	end process;
end sim;
