-- counter.vhd: Module to implement a 4-bit unsigned up counter with async clear

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
	port(clear : in  std_logic;
		 clock : in  std_logic;
	     count : out unsigned(3 downto 0));
end counter;

architecture rtl of counter is
	signal c : unsigned(3 downto 0);	-- 4-bit unsigned counter
begin
	process(clock, clear) is
	begin
		if clear = '1' then				-- asynchronous clear
			c <= "0000";
		elsif rising_edge(clock) then
			c <= c + 1;					-- up counter
		end if;
	end process;
	count <= c;							-- make count available to output parallel bus
end rtl;
