-- pe_tb.vhd: Testbench to test the priority encoder

library ieee;
use ieee.std_logic_1164.all;

entity pe_tb is
end pe_tb;

architecture sim of pe_tb is
	signal input  : std_logic_vector(7 downto 0);
	signal output : std_logic_vector(2 downto 0);
	signal valid  : std_logic;
begin
	uut : entity work.pe(behavioral) 
		  port map(input => input, output => output, valid => valid);
	process is
	begin
		input <= (others => '0');			wait for 10 ns;
		input <= (0 => '1', others => '-');	wait for 10 ns;
		input <= (1 => '1', others => '-');	wait for 10 ns;
		input <= (2 => '1', others => '-');	wait for 10 ns;
		input <= (3 => '1', others => '-');	wait for 10 ns;
		input <= (4 => '1', others => '-');	wait for 10 ns;
		input <= (5 => '1', others => '-');	wait for 10 ns;
		input <= (6 => '1', others => '-');	wait for 10 ns;
		input <= (7 => '1', others => '-');	wait for 10 ns;
		wait;
	end process;
end sim;
