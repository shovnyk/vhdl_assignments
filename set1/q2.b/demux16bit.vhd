-- demux16bit.vhd: Module to implement a 16 bit demulitplexer

library ieee;
use ieee.std_logic_1164.all;

entity demux16bit is
	port(D   : in  std_logic;
		 Sel : in  std_logic_vector(3 downto 0);
         Y   : out std_logic_vector(15 downto 0));
end demux16bit;

architecture structural of demux16bit is
	signal data : std_logic_vector(1 downto 0);
begin
	-- logic for a 1x2 demux
	data <= (D, '0') when Sel(3) = '1' else
			('0', D) when Sel(3) = '0' else
			"XX"; 

	-- build 1x16 demux out of two 1x8 demux's
	demux8_1 : entity work.demux8bit(behavioral) 
			   port map(D   => data(1),
					    Sel => Sel(2 downto 0),
						Y   => Y(15 downto 8));
	demux8_2 : entity work.demux8bit(behavioral)
			   port map(D   => data(0),
					    Sel => Sel(2 downto 0),
					    Y   => Y(7 downto 0));
end structural;
