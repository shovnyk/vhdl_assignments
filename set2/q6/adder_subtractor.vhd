-- adder_subtractor.vhd: Behavioral code to implement a 12 bit adder/subtractor.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_subtractor is
	-- use generic to allow for any number of btis
	generic(datawidth : integer);
	port(	-- inputs
			x	 : in unsigned(datawidth-1 downto 0);
			y	 : in unsigned(datawidth-1 downto 0);
			mode : in std_logic;

			-- outputs
			s	 : out unsigned(datawidth-1 downto 0);
			ov	 : out std_logic
		);
end entity;

architecture behavioral of adder_subtractor is
begin
	process(mode, x, y) is
	begin
		case mode is
			-- addition
			when '0' =>
				s  <= x + y;
				ov <= x(datawidth-1) and y(datawidth-1);
			-- subtraction
			when '1' =>
				s  <= x - y;
				ov <= 'X'; -- todo: logic to generate overflow bit for subtraction??
		end case;
	end process;
end behavioral;
