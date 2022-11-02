-- successive3.vhd: Module to identify when the input sequence has the same value 
-- for 3 successive clock cycles

library ieee;
use ieee.std_logic_1164.all;

entity successive3 is
	port (
			-- input
		    clk : in std_logic;
			rst : in std_logic;
			s	: in std_logic;
			
			-- output
			y	: out std_logic
		);
end successive3;

architecture moore1 of successive3 is

	-- declare abstract state type and signal of that type
	type abstract_type is (SR, S01, S11, S02, S12, S03, S13);
	signal state : abstract_type;

begin

	-- sequential logic for driving state change at clock edge (or respond to reset)
	seq: process(clk, rst) is
	begin
		if rst = '1' then
			state <= SR;
		
		elsif rising_edge(clk) then
			case state is

				when SR =>
					if s = '1' then
						state <= S11;
					elsif s = '0' then
						state <= S01;
					end if;

				when S11 =>
					if s = '1' then
						state <= S12;
					elsif s = '0' then
						state <= S01;
					end if;

				when S12 =>
					if s = '1' then
						state <= S13;
					elsif s = '0' then
						state <= S01;
					end if;

				when S13 =>
					if s = '1' then
						state <= S11;
					elsif s = '0' then
						state <= S01;
					end if;

				when S01 =>
					if s = '0' then
						state <= S02;
					elsif s = '1' then
						state <= S11;
					end if;

				when S02 =>
					if s = '0' then
						state <= S03;
					elsif s = '1' then
						state <= S11;
					end if;

				when S03 =>
					if s = '0' then
						state <= S01;
					elsif s = '1' then
						state <= S11;
					end if;

			end case;
		end if;
	end process;

	-- combinational logic to produce output based on state (Moore Machine)
	y <= '1' when state = S13 or state = S03 else
		 '0';

end moore1;
