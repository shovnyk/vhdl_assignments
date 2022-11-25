-- jkff_tb.vhd: Testbench to test the JK flipflop module

library ieee;
use ieee.std_logic_1164.all;

entity jkff_tb is
end jkff_tb;

architecture sim of jkff_tb is
	-- define constants
	constant freq  : integer := 100e6; 
	constant cycle : time := 1000 ms / freq;
	-- test signals
	signal   clk   : std_logic := '1';
	signal   nrst  : std_logic;
	signal   q, nq : std_logic;
	signal   j, k  : std_logic;
begin 
	-- generate clock signal
	clk <= not clk after cycle/2;
	-- instantiate module
	uut : entity work.jkff(rtl)
	      port map(Clk => clk, nRst => nrst, J => j, K => k, Q => q, nQ => nq);
	-- apply signals
	process is
	begin
		nrst <= '0'; wait for 1.3*cycle;
		nrst <= '1';
		j	 <= '1'; k <= '0'; wait for cycle;
		j	 <= '0'; k <= '0'; wait for cycle;
		j	 <= '0'; k <= '1'; wait for cycle;
		j	 <= '0'; k <= '0'; wait for cycle;
		j	 <= '1'; k <= '1'; wait for cycle;
		j	 <= '0'; k <= '0'; wait for cycle;
		j	 <= '1'; k <= '1'; wait for cycle;
		j	 <= '0'; k <= '0'; wait for cycle;
		wait;
	end process;
end sim;
