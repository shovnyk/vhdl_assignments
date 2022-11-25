-- tff.vhd: Module for implementing a T flip flop

library ieee;
use ieee.std_logic_1164.all;

entity tff is
	port(Clk, nRst : in  std_logic;
		        T  : in  std_logic;
                Q  : out std_logic;
               nQ  : out std_logic);
end tff;

architecture rtl of tff is
	signal state : std_logic;
begin
	process(Clk, nRst) is
	begin
		if (nRst = '0') then
			state <= '0';							-- asynchronous reset
		elsif rising_edge(Clk) and T = '1' then
			state <= not state;						-- toggle
		end if;
	end process;
	Q  <= state;
	nQ <= not state;
end rtl;

-- create T flip flop from JK flip flop
architecture structural of tff is
begin 
	jk_flipflop : entity work.jkff(rtl)
				  port map(Clk  => Clk,
						   nRst => nRst,
						   J	=> T,
						   K	=> T,
						   Q	=> Q,
						   nQ	=> nQ);
end structural;
