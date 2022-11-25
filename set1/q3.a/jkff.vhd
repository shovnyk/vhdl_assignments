-- jkff.vhd: Module to implement a JK flip flop

library ieee;
use ieee.std_logic_1164.all;

entity jkff is
	port( -- inputs
		  Clk  : in  std_logic;
		  nRst : in  std_logic;
		  J,K  : in  std_logic;
		  -- outputs
		  Q    : out std_logic; 
		  nQ   : out std_logic);
end jkff;

architecture rtl of jkff is

	signal state : std_logic;

begin

	seq: process(Clk, nRst) is
	begin
		if nRst = '0' then
			state <= '0';					-- asynchronous reset
		elsif rising_edge(Clk) then
			if J = '1' and K = '0' then
				state <= '1';				-- set
			elsif J = '0' and K = '1' then
				state <= '0';				-- reset
			elsif J = '1' and K = '1' then
				state <= not state;			-- toggle
			else
				state <= state;				-- retain
			end if;
		end if;
	end process;

	Q  <= state;
	nQ <= not state;

end rtl;
