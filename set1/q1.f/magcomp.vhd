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

	process(A, B) is 
	begin
		A_greater <= '0';
		B_greater <= '0';
		for i in 0 to N-1 loop
			if A(i) > B(i) then
				A_greater <= '1';
				B_greater <= '0';
			elsif A(i) < B(i) then
				A_greater <= '0';
				B_greater <= '1';
			end if;
		end loop;
	end process;

	both_equal <= (not A_greater) and (not B_greater);

end behavioral;
