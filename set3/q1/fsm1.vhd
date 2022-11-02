-- fsm1.vhd: Module to implement the Mealy machine FSM given in question 1

library ieee;
use ieee.std_logic_1164.all;

entity fsm1 is
	port(clock	: in std_logic;
		 reset	: in std_logic;
		 input	: in std_logic;
		 output : out std_logic);
end fsm1;

architecture mealy of fsm1 is

	type abstract_state is (s0, s1, s2, s3); 
	signal current_state, next_state : abstract_state;

begin

	combinational: process(current_state, input) is
	begin

		case current_state is
			when s0 =>
				if input = '0' then
					output <= '0';
					current_state <= s1;
				elsif input = '1' then
					output <= '1';
					current_state <= s2;
				end if;

			when s1 =>
				if input = '0' then
					output <= '0';
					current_state <= s3;
				elsif input = '1' then
					output <= '0';
					current_state <= s1;
				end if;

			when s2 =>
				if input = '0' then
					output <= '1';
					current_state <= s2;
				elsif input = '1' then
					output <= '0';
					current_state <= s3;
				end if;

			when s3 =>
				if input = '0' then
					output <= '1';
					current_state <= s3;
				elsif input = '1' then
					output <= '1';
					current_state <= s0;
				end if;
		end case;

	end process;

	memory: process(clock, reset) is
	begin
		if reset = '1' then
			current_state <= s0;
		elsif rising_edge(clock) then
			current_state <= next_state;
		end if;
	end process;

end mealy;
