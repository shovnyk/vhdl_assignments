-- crc_8_ccitt_tb.vhd: Testbench to test the CRC-8-CCITT module using sample inputs

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity crc_8_ccitt_tb is
end crc_8_ccitt_tb;

architecture sim of crc_8_ccitt_tb is
	constant cycle : time := 10 ns;
	signal   DIN   : std_logic;
	signal   CLK   : std_logic := '0';
	signal   CRC   : std_logic_vector(7 downto 0);
	signal   VOUT  : std_logic;
	signal   msg   : std_logic_vector(15 downto 0) := x"4800";
begin
	CLK <= not CLK after cycle/2;
	uut : entity work.crc_8_ccitt(rtl)
		  port map(DIN  => DIN,
			       CLK  => CLK,
			       CRC  => CRC,
			       VOUT => VOUT);
	process begin
		wait for 0.3*cycle;
		for i in msg'high downto 0 loop -- shift in bits into the module MSB first
			DIN <= msg(i);
			wait for cycle;
		end loop;
		wait;
	end process;
end sim;
