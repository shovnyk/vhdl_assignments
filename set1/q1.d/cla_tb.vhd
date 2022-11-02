-- cla_tb.vhd: Testbench for testing the 4 bit Carry Lookahead Adder

library ieee;
use ieee.std_logic_1164.all;

entity cla_tb is
end cla_tb;

architecture sim of cla_tb is
	constant N	   : integer := 4;
	signal   A     : std_logic_vector(N-1 downto 0) := x"A";
	signal   B     : std_logic_vector(N-1 downto 0) := x"B";
	signal	 S     : std_logic_vector(N-1 downto 0);
	signal   Cout  : std_logic;
begin
	uut : entity work.cla(dataflow) 
	      generic map(N => N)
		  port map(A => A, B => B, S => S, Cout => Cout);
	process begin
		wait for 10 ns; wait;
	end process;
end sim;

