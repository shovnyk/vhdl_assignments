-- one_counter_tb.vhd: Testbench to test the design of the 1's counter
-- todo: finish this

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity one_counter_tb is
end one_counter_tb;

architecture sim of one_counter_tb is

	constant freq   : integer   := 100e6;			-- 100 MHz clock
	constant period : time	    := 1000 ms / freq;	-- 10 ns cycle

	signal	 reset  : std_logic;
	signal	 input  : std_logic;
	signal   clock	: std_logic := '1';
	signal   count  : unsigned(3 downto 0);
	signal   stream : unsigned(15 downto 0) := x"A38E"; -- test bit stream

	-- A38E (hex) = 1010 0011 1000 1110 (binary) has 8 ones, so we expect 8 as
	-- as the answer

begin

	-- generate the clock signal 
	clock <= not clock after period/2;

	-- instantiate the counter module to test
	uut : entity work.one_counter(behavioral)
		  generic map(nbits => 4) -- need 4 bits for 16 bit number
		  port map(
					clock => clock,
					reset => reset,
					input => input,
					count => count
				  );

	-- simulation needs to be run for at least 16*periods
	stimulus: process is
	begin
		-- reset the device for little more than the first clock cycle
		reset <= '1'; wait for 1.3*period;

		-- then bring the device out of reset and inject input bit stream LSB first
		reset <= '0';
		for i in 0 to 15 loop
			input <= '0';
			wait for 0.4*period;
			input <= stream(i);
			wait for 0.6*period;
		end loop;

		-- assert reset once bit stream has been injected completely
		reset <= '1'; wait;
	end process stimulus;
	
end sim;
