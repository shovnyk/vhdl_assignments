-- mux4bit.vhd: Module to implement a 4 bit (4x1) multiplexer

library ieee;
use ieee.std_logic_1164.all;

entity mux4bit is
	port(D   : in  std_logic_vector(3 downto 0);
		 sel : in  std_logic_vector(1 downto 0);
		 Y   : out std_logic);
end mux4bit;

architecture behavioral of mux4bit is
begin
	with sel select 
		Y <= D(0) when "00",
			 D(1) when "01",
			 D(2) when "10",
			 D(3) when "11",
			 'X'  when others;
end behavioral;
