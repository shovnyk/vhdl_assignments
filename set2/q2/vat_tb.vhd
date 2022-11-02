-- vat_tb.vhd : Testbench to test the vat module

library ieee;
use ieee.std_logic_1164.all;

entity vat_tb is
end vat_tb;

architecture sim of vat_tb is

	-- define clock
	constant freq    : integer   := 100e6;
	constant cycle   : time	     := 1000 ms / freq;

	-- define intermediate signals
	signal   clk     : std_logic := '1'; 
	signal   nrst    : std_logic := '1';
	signal   x	     : std_logic;
	signal   y1, y2  : std_logic;

begin

	-- generate clock signal
	clk <= not clk after cycle/2;

	-- instantiate component for behavioral model
	uut1 : entity work.vat(behavioral)
		   port map(x => x, y => y1, clk => clk, nrst => nrst);

	-- instantiate component for dataflow model
	uut2: entity work.vat(dataflow)
		  port map(x => x, y => y2, clk => clk, nrst => nrst);

	-- apply stimulus
	process is
	begin
		nrst <= '0'; wait for 1.3*cycle;
		nrst <= '1';

		x	 <= '0'; wait for 0.4*cycle;
		x	 <= '1'; wait for 0.6*cycle;
		x	 <= '0'; wait for 0.4*cycle;
		x	 <= '0'; wait for 0.6*cycle;
		x	 <= '0'; wait for 0.4*cycle;
		x	 <= '1'; wait for 0.6*cycle;
		x	 <= '0'; wait for 0.4*cycle;
		x	 <= '0'; wait for 0.6*cycle;

		nrst <= '0'; wait;
	end process;

end sim;
