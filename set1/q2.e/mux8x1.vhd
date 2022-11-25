-- mux8x1.vhd: Module to implement an 8x1 MUX

library ieee;
use ieee.std_logic_1164.all;

entity mux8x1 is
	port(data : in std_logic_vector(7 downto 0);
		 sel   : in std_logic_vector(2 downto 0);
         Y     : out std_logic);
end mux8x1;

architecture behavioral of mux8x1 is
begin
	with sel select
		Y <= data(0) when O"0",
			 data(1) when O"1",
			 data(2) when O"2",
			 data(3) when O"3",
			 data(4) when O"4",
			 data(5) when O"5",
			 data(6) when O"6",
			 data(7) when O"7",
			 'X'	 when others;
end behavioral;
