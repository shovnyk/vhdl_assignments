-- counter_control.vhd: Module to implement a counter that counts 16 clock cycles and 
-- outputs high on the eighth and twelfth cycles.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_control is
	port(
			clk  : in std_logic;
			rst  : in std_logic;
		    CTRL : out std_logic
		);
end counter_control;

architecture behavioral of counter_control is

	-- 16 = 2^4 clock cycles need to be counted so we need a 4 bit counter
	signal state : unsigned(3 downto 0);

begin

	-- count clock cycles or reset
	process(clk, rst) is
	begin
		if rst = '1' then 
			state <= "0000";
		elsif rising_edge(clk) then -- count clock cyles at every rising edge
			state <= state + 1;
		end if;
	end process;

	-- decode output based on state
	CTRL <= '1' when state = 7 or state = 11 else '0';
	
end behavioral;
