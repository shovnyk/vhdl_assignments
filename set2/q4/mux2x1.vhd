-- mux2x1.vhd: Module design for a 3-bit 2 to 1 MUX

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2x1 is
	port(
			-- inputs
			in0 : in unsigned(2 downto 0);
			in1 : in unsigned(2 downto 0);

			-- selector
			sel : in std_logic;

			-- output
			y : out unsigned(2 downto 0)
		);
end mux2x1;

architecture behavioral of mux2x1 is
begin
	-- concurrent implementation using with-select conditional signal assignment
	y <= in0 when sel = '0' else
		 in1 when sel = '1' else
		 "XXX";
end behavioral;
