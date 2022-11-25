-- counter_control.vhd: 5 bit counter that prodcues high for 4th, 20th, and 24th cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_control is
	port(   -- inputs
			clock   : in std_logic;
			reset   : in std_logic;
			-- outputs
			control : out std_logic
		);
end counter_control;

architecture behavioral of counter_control is

	-- intermediate signal for counting clock edges
	signal state : unsigned(4 downto 0);

begin

	process(clock, reset) is
	begin
		-- asynchronous reset
		if reset = '1' then
			state <= "00000";
		-- increment state whenever a clock edge is received
		elsif rising_edge(clock) then
			state <= state + 1;
		end if;
	end process;

	control <= '1' when state = 3 or state = 19 or state = 23 else '0';

end behavioral;
