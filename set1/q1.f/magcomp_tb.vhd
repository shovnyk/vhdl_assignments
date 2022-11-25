-- magcomp_tb.vhd: Testbench to test a 4 bit magnitude comparator
library ieee;
use ieee.std_logic_1164.all;

entity magcomp_tb is
end magcomp_tb;

architecture sim of magcomp_tb is

	constant N		    : integer := 4;
	signal	 A 		    : std_logic_vector(3 downto 0);
	signal	 B 		    : std_logic_vector(3 downto 0);
	signal   A_greater  : std_logic;
	signal   B_greater  : std_logic;
	signal   both_equal : std_logic;

begin

	uut : entity work.magcomp(behavioral) 
		  port map(A		  => A,
				   B		  => B,
				   A_greater  => A_greater,
				   B_greater  => B_greater,
				   both_equal => both_equal);

	process is
	begin
		A <= x"F"; B <= x"A"; wait for 10 ns;
		A <= x"1"; B <= x"2"; wait for 10 ns;
		A <= x"A"; B <= x"A"; wait for 10 ns;
		A <= x"B"; B <= x"B"; wait for 10 ns;
		wait;
	end process;

end sim;
