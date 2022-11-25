-- bcd2gray.vhd: Module to convert BCD to Gray code using Decoder

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd2gray is
	port(BCD_in   : in  unsigned(3 downto 0);
		 Gray_out : out unsigned(3 downto 0));
end bcd2gray;

architecture structural of bcd2gray is
	signal BCD_out : unsigned(15 downto 0);
begin
	-- generate minterms using the 4x16 decoder
	decoder : entity work.decoder4x16(behavioral)
			  port map(input => BCD_in, output => BCD_out);
	-- OR minterms using SOP form of the function
	Gray_out(3) <= BCD_out(8) or BCD_out(9);
	Gray_out(2) <= BCD_out(4) or BCD_out(5) or BCD_out(6) or BCD_out(7)
				   or BCD_out(8) or BCD_out(9);
	Gray_out(1) <= BCD_out(2) or BCD_out(3) or BCD_out(4) or BCD_out(5);
	Gray_out(0) <= BCD_out(1) or BCD_out(2) or BCD_out(5) or BCD_out(6) or
				   BCD_out(9);
end structural;
