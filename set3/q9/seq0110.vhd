-- seq0110.vhd: Module to detect the sequence 0110 (using Moore FSM)

library ieee;
use ieee.std_logic_1164.all;

entity seq0110 is
	port(clk : in std_logic;
		 rst : in std_logic;
           x : in std_logic;
	       z : out std_logic);
end seq0110;

architecture moore of seq0110 is

	type abstract_state is (A, B, C, D, E);
	signal state : abstract_state;

begin
	
	process(clk, rst) is
	begin

		if rst = '1' then
			state <= A;

		elsif rising_edge(clk) then
			case state is
				when A =>
					if x = '0' then
						state <= B;
					elsif x = '1' then
						state <= A;
					end if;

				when B =>
					if x = '1' then
						state <= C;
					elsif x = '0' then
						state <= B;
					end if;

				when C =>
					if x = '1' then
						state <= D;
					elsif x = '0' then
						state <= B;
					end if;

				when D =>
					if x = '0' then
						state <= E;
					elsif x = '1' then
						state <= A;
					end if;

				when E =>
					if x = '0' then
						state <= B;
					elsif x = '1' then
						state <= A;
					end if;
			end case;
		end if;

	end process;

	z <= '1' when state = E else '0';

end moore;
