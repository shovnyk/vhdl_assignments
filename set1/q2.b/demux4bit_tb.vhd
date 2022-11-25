-- dmeux4bit_tb.vhd: Testbench to test the 4-bit demuliplexer module
library ieee;
use ieee.std_logic_1164.all;

entity demux4bit_tb is
end demux4bit_tb;

architecture sim of demux4bit_tb is
	signal D : std_logic := '1';
	signal Y : std_logic_vector(3 downto 0);
	signal Sel : std_logic_vector(1 downto 0);
begin
	uut : entity work.demux4bit(behavioral) 
	      port map(D => D, Y => Y, Sel => Sel);
	process begin
		Sel <= "00"; 
			D <= '0'; wait for 10 ns;
			D <= '1'; wait for 10 ns;
		Sel <= "01"; 
			D <= '0'; wait for 10 ns;
			D <= '1'; wait for 10 ns;
		Sel <= "10";
			D <= '0'; wait for 10 ns;
			D <= '1'; wait for 10 ns;
		Sel <= "11";
			D <= '0'; wait for 10 ns;
			D <= '1'; wait for 10 ns;
		wait;
	end process;
end sim;
