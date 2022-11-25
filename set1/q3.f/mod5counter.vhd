-- mod5counter.vhd: Module to create a modulo-5 counter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mod5counter is
	port(clk  : in  std_logic;
		 rst  : in  std_logic);
end mod5counter;

architecture behavioral of mod5counter is
	signal count : unsigned(2 downto 0);
begin
	process(clk, rst) is
	begin
		if rst = '1' then
			count <= (others => '0');
		elsif rising_edge(clk) then
			if count = "101" then
				count <= (others => '0');
			else
				count <= count + 1;
			end if;
		end if;
	end process;
end behavioral;
