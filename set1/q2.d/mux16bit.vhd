-- mux16bit.vhd: Module to implement a 16 bit (16x1) multiplexer

library ieee;
use ieee.std_logic_1164.all;

entity mux16bit is
	port(D   : in  std_logic_vector(15 downto 0);
		 sel : in  std_logic_vector(3 downto 0);
         Y   : out std_logic);
end mux16bit;

architecture structural of mux16bit is
	component mux8bit is
		port(D   : in  std_logic_vector(7 downto 0);
			 sel : in  std_logic_vector(2 downto 0);
	         Y   : out std_logic);
	end component;
	signal Y0, Y1 : std_logic;
begin
	-- construct 16x1 MUX from two 8x1 MUX's
	MUX1 : mux8bit port map(D	=> D(15 downto 8),
						    sel => sel(3 downto 1),
						    Y   => Y0);
	MUX2 : mux8bit port map(D	=> D(7 downto 0),
						    sel => sel(3 downto 1),
						    Y   => Y1);
	Y <= Y1 when sel(0) = '1' else 
		 Y0 when sel(0) = '0' else
		 'X';
end structural;
