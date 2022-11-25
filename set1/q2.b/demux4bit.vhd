-- demux4bit.vhd: Module to implement a 4-bit (1 to 4 line) demultiplexer

library ieee;
use ieee.std_logic_1164.all;

entity demux4bit is
	port(	-- inputs
			D				: in  std_logic;
			-- select
			Sel				: in  std_logic_vector(1 downto 0);
			-- outputs
			Y				: out std_logic_vector(3 downto 0)
		);
end demux4bit;

architecture behavioral of demux4bit is 
begin
	with Sel select
		Y <= (0 => D, others => '0') when "00",
			 (1 => D, others => '0') when "01",
			 (2 => D, others => '0') when "10",
			 (3 => D, others => '0') when "11",
			 (others => 'X')		 when others;
end behavioral;
