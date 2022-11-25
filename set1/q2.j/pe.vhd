-- pe.vhd: Module to implement an Priority Octal-to-Binary Encoder

library ieee;
use ieee.std_logic_1164.all;

entity pe is
	port(input  : in  std_logic_vector(7 downto 0);
		 output : out std_logic_vector(2 downto 0);
		 valid  : out std_logic);
end pe;

architecture behavioral of pe is
begin
	-- priority encoder logic: the more significant bit gets encoded
	output <= "111" when input(7) = '1' else
			  "110" when input(6) = '1' else
			  "101" when input(5) = '1' else
			  "100" when input(4) = '1' else
			  "011" when input(3) = '1' else
			  "010" when input(2) = '1' else
			  "001" when input(1) = '1' else
			  "000" when input(0) = '1' else
			  "XXX";

	-- valid bit is set to 0 when none of the input lines is set high
	valid <= '0' when input = x"00" else 
			 '1';
end behavioral;
