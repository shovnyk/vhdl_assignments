-- bcd2xs3_tb.vhd: Testbench to test the BCD to Excess-3 Converter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd2xs3_tb is
end bcd2xs3_tb;

architecture sim of bcd2xs3_tb is
	signal BCD_in  : unsigned(3 downto 0);
	signal XS3_out : unsigned(3 downto 0);
begin
	uut : entity work.bcd2xs3(structural)
		  port map(BCD_in => BCD_in, XS3_out => XS3_out);
	process is
	begin
		for i in 0 to 9 loop
			BCD_in <= to_unsigned(i, 4);
			wait for 10 ns;
		end loop;
		wait;
	end process;
end sim;
