library ieee;
use ieee.std_logic_1164.all;

entity tff_tb is
end tff_tb;

architecture sim of tff_tb is

	constant ClockFrequency : integer := 100e6; -- 100 MHz
	constant ClockPeriod : time := 1000 ms / ClockFrequency; -- 1 cycle = 10 ns

	signal Clk  : std_logic := '0';
	signal nRst : std_logic;
	signal T    : std_logic := '0';
	signal Q    : std_logic;
	signal nQ   : std_logic;

begin

	-- instantiate the d flip flop
	uut : entity work.tff(structural) 
	port map( Clk => Clk,
			   nRst => nRst,
				  T => T,
				  Q => Q,
				 nQ => nQ);

	-- process to generate clock signal (will run indefinitely)
	Clk <= (not Clk) after ClockPeriod/2;

	-- process to generate test signals
	process is
	begin

		-- reset the device for the first 2 clock cycles
		nRst <= '0'; wait for 20 ns;

		-- take the device out of reset
		nRst <= '1';

		-- apply inputs
		T <= not T; wait for 10 ns;
		T <= not T; wait for 2 ns;
		T <= not T; wait for 8 ns;
		T <= not T; wait for 12 ns;
		T <= not T; wait for 23 ns;
		T <= not T; wait for 7 ns;

		-- reset the device again
		nRst <= '0'; wait for 20 ns;

		-- before stopping
		wait;

	end process;

end sim;
