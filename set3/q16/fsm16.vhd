-- fsm16.vhd: Module to implement the hybrid Mealy/Moore FSM in question 16

library ieee;
use ieee.std_logic_1164.all;

entity fsm16 is
	port( 
		  Z1, Z2 : out std_logic;
		  Y1, Y2 : out std_logic; -- state bits as output for testing
		  X1, X2 : in std_logic;
		  clk	 : in std_logic;
		  rst	 : in std_logic
	    );
end fsm16;

architecture hybrid of fsm16 is

	type abstract_state is (a, b, c);
	signal PS, NS : abstract_state;
	signal input  : std_logic;

begin

	-- drive state machine forward at every clock edge or reset
	mem: process(rst, clk) is
	begin
		if rst = '1' then
			PS <= c;
		elsif rising_edge(clk) then
			PS <= NS;
		end if;
	end process;

	-- decide next state and output bit Z1 based on current state and input
	mealy: process(PS, X1, X2) is 
	begin
		case PS is

			when (a) =>
				if X1 = '1' then Z1 <= '1';
					NS <= (b);
				elsif X1 = '0' then Z1 <= '0';
					NS <= a;
				end if;

			when (b) =>
				if X2 = '1' then
					Z1 <= '0';
					NS <= (a);
				elsif X2 = '1' then
					Z1 <= '1';
					NS <= c;
				end if;

			when (c) =>
				if X2 = '1' then 
					Z2 <= '1';
					NS <= (c);
				elsif X2 = '0' then
					Z2 <= '0';
					NS <= a;
				end if;

		end case;

	end process;

	-- decide state bits Y2, Y1 and output bit Z2 based on current state
	moore: process(PS) is 
	begin
		case PS is

			when (a) =>
				Y2 <= '1'; Y1 <= '1';
				-------------------
					Z2 <= '1';

			when (b) =>
				Y2 <= '0'; Y1 <= '1';
				-------------------
					Z2 <= '0';

			when (c) =>
				Y2 <= '0'; Y1 <= '0';
				-------------------
					Z2 <= '1';

		end case;
	end process;

end hybrid;
