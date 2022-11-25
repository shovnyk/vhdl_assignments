-- mod2counter.vhd: Module to implement a mod 2 counter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mod2counter is
	port(rst : in std_logic;
		 clk : in std_logic);
end mod2counter;

architecture behavioral of mod2counter is
	signal count : std_logic;
begin
	process(clk, rst) is
	begin
		if rst = '1' then
			count <= '0';
		elsif rising_edge(clk) then
			count <= not count;
		end if;
	end process;
end behavioral;
