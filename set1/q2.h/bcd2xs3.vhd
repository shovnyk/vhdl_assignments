-- bcd2xs3.vhd: Module to implement a BCD to Excess-3 converter using a Decoder

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd2xs3 is
	port(BCD_in  : in  unsigned(3 downto 0);
		 XS3_out : out unsigned(3 downto 0));
end bcd2xs3;

architecture structural of bcd2xs3 is
	signal BCD_out : std_logic_vector(15 downto 0);
begin
	-- generate minterms using 4x16 decoder
	decoder : entity work.decoder4x16(behavioral)
			  port map(input => BCD_in, output => BCD_out);

	-- OR minterms using SOP form of function
	XS3_out(3) <= BCD_out(5) or BCD_out(6) or BCD_out(7) or BCD_out(8) or BCD_out(9);
	XS3_out(2) <= BCD_out(1) or BCD_out(2) or BCD_out(3) or BCD_out(4) or BCD_out(9);
	XS3_out(1) <= BCD_out(0) or BCD_out(3) or BCD_out(4) or BCD_out(7) or BCD_out(8);
	XS3_out(0) <= BCD_out(0) or BCD_out(2) or BCD_out(4) or BCD_out(6) or BCD_out(8);
end structural;
