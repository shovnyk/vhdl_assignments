-- dff.vhd: Module to implement a D flip flop

library ieee;
use ieee.std_logic_1164.all;

entity dff is
	port( Clk, nRst : in  std_logic;
		          D : in  std_logic;
			      Q : out std_logic;
			     nQ : out std_logic);
end dff;

architecture rtl of dff is
	signal state : std_logic;
begin
	seq: process(Clk, nRst) is
	begin
		if nRst = '0' then
			state <= '0';				-- asynchronous reset
		elsif rising_edge(Clk) then
			state <= D;					-- sample input
		end if;
	end process;
	Q  <= state;
	nQ <= not state;
end rtl;
