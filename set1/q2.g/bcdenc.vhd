-- bcdenc.vhd: Module to implement BCD encoder

library ieee;
use ieee.std_logic_1164.all;

entity bcdenc is
	port(input  : in  std_logic_vector(9 downto 0);
		 output : out std_logic_vector(3 downto 0);
	     valid  : out std_logic);
end bcdenc;

-- valid BCD characters are 0 to 9
architecture dataflow of bcdenc is
begin
	output <= x"9" when input(9) = '1' else
			  x"8" when input(8) = '1' else
			  x"7" when input(7) = '1' else
			  x"6" when input(6) = '1' else
			  x"5" when input(5) = '1' else
			  x"4" when input(4) = '1' else
			  x"3" when input(3) = '1' else
			  x"2" when input(2) = '1' else
			  x"1" when input(1) = '1' else
			  x"0" when input(0) = '1' else
			  (others => 'X');
	valid <= '0' when input = "0000000000" else '1';
end dataflow;
