-- muxtree64bit.vhd: Module to implement a 64-bit MUX tree

library ieee;
use ieee.std_logic_1164.all;

entity muxtree64bit is
	port(D   : in  std_logic_vector(63 downto 0);
		 Sel : in  std_logic_vector(5 downto 0);
		 Y   : out std_logic);
end muxtree64bit;

architecture structural of muxtree64bit is
	signal data : std_logic_vector(3 downto 0);
begin
	mux1 : entity work.mux16bit(behavioral)
	       port map(D => D(63 downto 48), Sel => Sel(5 downto 2), Y => data(3));
	mux2 : entity work.mux16bit(behavioral)
	       port map(D => D(47 downto 32), Sel => Sel(5 downto 2), Y => data(2));
	mux3 : entity work.mux16bit(behavioral)
	       port map(D => D(31 downto 16), Sel => Sel(5 downto 2), Y => data(1));
	mux4 : entity work.mux16bit(behavioral)
	       port map(D => D(15 downto 0), Sel => Sel(5 downto 2), Y => data(0));
	mux5 : entity work.mux4bit(behavioral)
	       port map(D => data, Sel => Sel(1 downto 0), Y => Y);
end structural;
