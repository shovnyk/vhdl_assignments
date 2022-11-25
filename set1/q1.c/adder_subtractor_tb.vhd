-- adder_subtractor_tb.vhd: Testbench to test the adder subtractor module

library ieee;
use ieee.std_logic_1164.all;

entity adder_subtractor_tb is
end adder_subtractor_tb;

architecture sim of adder_subtractor_tb is
	constant nbits : integer := 4;
	signal   A	   : std_logic_vector(nbits-1 downto 0);
	signal   B 	   : std_logic_vector(nbits-1 downto 0);
	signal   M     : std_logic;
	signal   S 	   : std_logic_vector(nbits-1 downto 0);
	signal   Ov    : std_logic;
	signal   Cout  : std_logic;
begin
	uut : entity work.adder_subtractor(dataflow)
		  generic map(nbits => nbits)
		  port map(A => A, B => B, S => S, M => M, Cout => Cout, Ov => Ov);
	process begin
		-- addition (mode select line = '0')
		M <= '0'; A <= x"7"; B <= x"5"; wait for 10 ns;
				  A <= x"5"; B <= x"7"; wait for 10 ns;
		          A <= x"F"; B <= x"4"; wait for 10 ns;
		-- subtraction (mode select line = '1')
		M <= '1'; A <= x"7"; B <= x"5"; wait for 10 ns;
				  A <= x"5"; B <= x"7"; wait for 10 ns;
		          A <= x"F"; B <= x"4"; wait for 10 ns;
		wait;
	end process;
end sim;
