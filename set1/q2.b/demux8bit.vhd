-- demux8bit.vhd: Module to implement an 8-bit demultiplexer

library ieee;
use ieee.std_logic_1164.all;

entity demux8bit is
	port(
			-- inputs
			D   : in  std_logic;
			-- select
			Sel : in  std_logic_vector(2 downto 0);
			-- outputs
			Y   : out std_logic_vector(7 downto 0)
		);
end demux8bit;

architecture behavioral of demux8bit is
begin
	with Sel select
		Y <= (0 => D, others => '0') when O"0",
			 (1 => D, others => '0') when O"1",
			 (2 => D, others => '0') when O"2",
			 (3 => D, others => '0') when O"3",
			 (4 => D, others => '0') when O"4",
			 (5 => D, others => '0') when O"5",
			 (6 => D, others => '0') when O"6",
			 (7 => D, others => '0') when O"7",
			 (others => 'X')		 when others;
end behavioral;
