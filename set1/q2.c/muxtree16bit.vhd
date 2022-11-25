-- muxtree16bit.vhd: Module to implement a 16-bit MUX tree

library ieee;
use ieee.std_logic_1164.all;

entity muxtree16bit is
	port(D   : in  std_logic_vector(15 downto 0);
		 sel : in  std_logic_vector(3 downto 0);
		 Y   : out std_logic);
end muxtree16bit;

architecture structural of muxtree16bit is
	signal data : std_logic_vector(3 downto 0);
begin
	mux1 : entity work.mux4bit(behavioral)
		   port map(D => D(15 downto 12), Sel => Sel(3 downto 2), Y => data(3));
	mux2 : entity work.mux4bit(behavioral)
		   port map(D => D(11 downto 8), Sel => Sel(3 downto 2), Y => data(2));
	mux3 : entity work.mux4bit(behavioral)
		   port map(D => D(7 downto 4), Sel => Sel(3 downto 2), Y => data(1));
	mux4 : entity work.mux4bit(behavioral)
		   port map(D => D(3 downto 0), Sel => Sel(3 downto 2), Y => data(0));
	mux5 : entity work.mux4bit(behavioral)
		   port map(D => data, Sel => Sel(1 downto 0), Y => Y);
end structural;
