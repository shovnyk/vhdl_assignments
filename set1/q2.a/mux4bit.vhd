-- mux4bit.vhd: Module to implement a 4 bit (4x1) multiplexer

library ieee;
use ieee.std_logic_1164.all;

entity mux4bit is
	port(A, B, C, D : in  std_logic;
				sel : in  std_logic_vector(1 downto 0);
			      Y : out std_logic);
end mux4bit;

architecture behavioral of mux4bit is
begin
	with sel select 
		Y <= A   when "00",
			 B   when "01",
			 C   when "10",
			 D   when "11",
			 'X' when others;
end behavioral;
