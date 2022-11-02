-- tff.vhd: Module for implementing a T flip flop

library ieee;
use ieee.std_logic_1164.all;

entity tff is
	port(Clk, nRst : in  std_logic;
		        T  : in  std_logic;
                Q  : out std_logic;
               nQ  : out std_logic);
end tff;

architecture behavioral of tff is
	signal state : std_logic;
begin
	process(Clk, nRst) is
	begin
		if (nRst = '0') then
			state <= '0';
		elsif rising_edge(Clk) and T = '1' then
			state <= not state;
		end if;
	end process;
	Q  <= state;
	nQ <= not state;
end behavioral;

-- create T flip flop from JK flip flop
architecture structural of tff is
	signal X : std_logic;
begin 
	X <= not T;
	jk_flipflop : entity work.jkff
				  port map(Clk  => Clk,
						   nRst => nRst,
						   J	=> T,
						   K	=> X,
						   Q	=> Q,
						   nQ	=> Q);
end structural;
