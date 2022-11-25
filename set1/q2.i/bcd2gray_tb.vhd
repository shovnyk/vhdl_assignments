-- bcd2gray_tb.vhd: Testbench to test the BCD to Gray code converter module
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd2gray_tb is
end bcd2gray_tb;

architecture sim of bcd2gray_tb is
	signal BCD_in  : unsigned(3 downto 0);
	signal Gray_out : unsigned(3 downto 0);
begin
	uut : entity work.bcd2gray(structural)
		  port map(BCD_in => BCD_in, Gray_out => Gray_out);
	process is
	begin
		for i in 0 to 9 loop
			BCD_in <= to_unsigned(i, 4);
			wait for 10 ns;
		end loop;
		wait;
	end process;
end sim;

