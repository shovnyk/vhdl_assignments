-- fa_4bit_tb.vhd: Testbench to test the 4 bit (ripple carry) adder module

library ieee;
use ieee.std_logic_1164.all;

entity fa_4bit_tb is
end fa_4bit_tb;

architecture sim of fa_4bit_tb is
	constant nbits : integer := 4;
	signal   A     : std_logic_vector(nbits-1 downto 0);
	signal   B     : std_logic_vector(nbits-1 downto 0);
	signal	 S     : std_logic_vector(nbits-1 downto 0);
	signal   Cout  : std_logic;
begin
	uut : entity work.fa_4bit(dataflow) 
	      generic map(N => nbits)
		  port map(A => A, B => B, S => S, Cout => Cout);
	process begin
		A <= x"0"; B <= x"0"; wait for 10 ns;
		A <= x"2"; B <= x"3"; wait for 10 ns;
		A <= x"A"; B <= x"3"; wait for 10 ns;
		A <= x"F"; B <= x"F"; wait for 10 ns;
		wait;
	end process;
end sim;
