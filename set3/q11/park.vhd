-- park.vhd: Module to implement the car parking FSM
-- todo: finish this

library ieee;
use ieee.std_logic_1164.all;

entity park is
	port(
			-- inputs
			sensor_entrance : in  std_logic;
			sensor_exit	    : in  std_logic
			clock			: in  std_logic;
			reset			: in  std_logic;
			password_valid  : in  std_logic;

			-- outputs: examine the state of the FSM
			state			: out std_logic_vector(4 downto 0);
		);
end park;

architecture behavioral of park is

	type abstract_state is (IDLE, WAIT_PASSWORD, RIGHT_PASS, WRONG_PASS, STOP);
	signal current_state, next_state : abstract_state;

begin

	comb: process(sensor_entrance, current_state) is
	begin
		case current_state is

			when IDLE =>
				if sensor_entrance = '1' then
					next_state <= WAIT_PASSWORD;
				end if;

			when WAIT_PASSWORD =>
				if password_valid = '1' then 
					next_state <= RIGHT_PASS;
				elsif password_valid = '0' then
					next_state <= WRONG_PASS;
				end if;

			when RIGHT_PASS =>
				if sensor_exit = '1' and sensor_entrance /= '0' then
					next_state <= IDLE;
				elsif sensor_exit = '1' and sensor_entrance = '1' then
					next_state <= STOP;
				elsif sensor_exit = '0' then
					next_state <= RIGHT_PASS;
				end if;
					
			when WRONG_PASS =>
				if password_valid = '1' then
					next_state <= RIGHT_PASS;
				elsif password_valid = '0' then
					next_state <= WRONG_PASS;
				end if;

			when STOP =>
				if password_valid = '1' then
					next_state <= RIGHT_PASS;
				elsif password_valid = '0' then
					next_state <= STOP;
				end if;

		end case;
	end process;

	mem: process(clock, reset) is
	begin
		if reset = '1' then
			current_state <= IDLE;
		elsif rising_edge(clock) then
			current_state <= next_state;
		end if;
	end process;

	-- provide state encoding (one hot coding) for the sake of testing
	with current_state select
		state <= "00001" when IDLE,
				 "00010" when WAIT_PASSWORD,
				 "00100" when RIGHT_PASS,
				 "01000" when WRONG_PASS,
				 "10000" when STOP,
				 "XXXXX" when others;

end behavioral;
