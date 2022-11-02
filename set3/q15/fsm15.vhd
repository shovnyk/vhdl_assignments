-- fsm15.vhd: Module to implement the Mealy FSM in question 15

library ieee;
use ieee.std_logic_1164.all;

entity fsm15 is
	port(
			clk : in std_logic;
		    set : in std_logic;
		      x : in std_logic;
			 z2 : out std_logic;
			  y : out std_logic_vector(1 downto 0) -- state output for testing
		);
end fsm15;

architecture mealy of fsm15 is

	signal PS, NS : std_logic_vector(1 downto 0);

begin

	mem: process(clk, set) is
	begin
		if set = '1' then
			PS <= "11";
		elsif rising_edge(clk) then
			PS <= NS;
		end if;
	end process;

	comb: process(PS, x) is 
	begin
		case PS is 
			when "00" =>
				if x = '0' then
					z2 <= '0';
					NS <= "00";
				elsif x = '1' then
					z2 <= '0';
					NS <= "10";
				end if;
			when "10" =>
				if x = '0' then
					z2 <= '0';
					NS <= "00";
				elsif x = '1' then
					z2 <= '0';
					NS <= "11";
				end if;
			when "11" =>
				if x = '1' then
					z2 <= '1';
					NS <= "11";
				elsif x = '0' then
					z2 <= '0';
					NS <= "00";
				end if;
			when others =>
				PS <= "11";
				z2 <= 'X';
		end case;
	end process;

	y <= PS; -- output current state for examination

end mealy;
