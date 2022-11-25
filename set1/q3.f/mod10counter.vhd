-- mod10counter.vhd: Module to implement a mod 10 counter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mod10counter is
	port(clk, rst : in std_logic);
end mod10counter;

architecture behavioral of mod10counter is
	signal count : unsigned(3 downto 0);
begin
	process(clk, rst) is
	begin
		if rst = '1' then
			count <= (others => '0');
		elsif rising_edge(clk) then
			if count = "1001" then
				count <= (others => '0');
			else
				count <= count + 1;
			end if;
		end if;
	end process;
end behavioral;
