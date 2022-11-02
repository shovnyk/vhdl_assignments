-- counter_control_tb.vhd: Testbench to test the counter_control

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_control_tb is
end counter_control_tb;

architecture sim of counter_control_tb is

	constant freq	: integer	:= 100e6; 
	constant cycle	: time		:= 1000 ms / freq;

	signal clock	: std_logic := '1';
	signal reset	: std_logic;
	signal control	: std_logic := '0';

begin

	-- generate clock signal
	clock <= not clock after 10 ns;

	-- instantiate module to be tested
	uut : entity work.counter_control(behavioral)
	      port map(clock => clock, reset => reset, control => control);

	-- apply stimulus
	process is
	begin
		-- reset the device then bring it out of reset
		reset <= '1';
		wait for 0.3*cycle;
		reset <= '0'; 
		wait;
	end process;

end sim;
