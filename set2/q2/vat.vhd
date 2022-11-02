-- vat.vhd: Module to implement the vat pump open/close logic

library ieee;
use ieee.std_logic_1164.all;

entity vat is
	port(
			-- inputs
			x	 : in std_logic;
			clk  : in std_logic;
		    nrst : in std_logic; -- active low asynchronous reset

			-- output
			y   : out std_logic
		);
end vat;

architecture behavioral of vat is

	type abstract_state is (empty, not_empty);
	signal state : abstract_state;

begin

	process(clk, nrst) is
	begin

		-- when reset is asserted make the vat non-empty
		if nrst = '0' then
			state <= not_empty;
		
		-- respond to input only at the rising edge of the clock
		elsif rising_edge(clk) then
			case state is
				when empty =>
					state <= empty;
				when not_empty =>
					if x = '1' then
						state <= empty;
					elsif x = '0' then
						state <= not_empty;
					end if;
			end case;

		end if;

	end process;

	-- decode output based on state
	y <= '1' when state = empty else
		 '0' when state = not_empty;

end behavioral;

architecture dataflow of vat is

	-- signals for the flip flop
	signal D : std_logic;
	signal Q : std_logic;

begin

	-- sequential logic for the D flip flop
	dff: process(clk, nrst) is
	begin
		if nrst = '0' then
			Q <= '0';
		elsif nrst = '1' then
			Q <= D;
		end if;
	end process;

	-- combinational logic (concurrent statements) for next state and output
	D <= Q or X;
	Y <= Q;

end dataflow;
