-- deecoder4x16.vhd: Module to implement a 4x16 decoder

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder4x16 is
	port(input  : in  unsigned(3 downto 0);
		 output : out unsigned(15 downto 0));
end entity;

architecture behavioral of decoder4x16 is
begin
	process(input) is
	begin
		-- set minterm corresponding to input to '1', rest to '0'
		output <= (others => '0');
		output(to_integer(input)) <= '1';
	end process;
end behavioral;
