-- magcomp.vhd: Module to implement a 4 bit magnitude comparator

library ieee;
use ieee.std_logic_1164.all;

entity magcomp is
	generic(N : integer := 4);
	port ( -- inputs
		   A, B : in std_logic_vector(N-1 downto 0);
		   -- ouputs
		   A_greater, B_greater, both_equal : inout std_logic);
end entity;

architecture behavioral of magcomp is
begin
	Comparator: for i in 0 to N-1 generate
		greater_bit: if A(i) > B(i) generate
			A_greater <= '1';
			B_greater <= '0';
		end generate greater_bit;
	end generate Comparator;
	both_equal <= (not A_greater) and (not B_greater);
end behavioral;
