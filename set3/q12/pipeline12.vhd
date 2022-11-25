-- pipeline12.vhd: Module to implement a 3 stage pipeline for computing averages

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipeline12 is
	port( a,b,c : in  signed(5 downto -8);
		    clk : in  std_logic;
	     output : out signed(5 downto -8));
end pipeline12;

architecture rtl of pipeline12 is
	signal x, cp, y, z : signed(5 downto -8);
begin
	process(clk) begin
		if rising_edge(clk) then

			-- stage 1
			x <= a + b;
			cp <= c;
			
			-- stage 2
			y <= x + cp;

			-- stage 3
			z <= y/3;

		end if;
	end process;
	output <= z;
end rtl;
