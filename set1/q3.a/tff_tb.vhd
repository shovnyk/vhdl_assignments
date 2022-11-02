-- tff_tb.vhd: Testbench to test the T flipflop module

library ieee;
use ieee.std_logic_1164.all;

entity tff_tb is
end tff_tb;

architecture sim of tff_tb is
	-- define constants
	constant freq  : integer := 100e6; 
	constant cycle : time := 1000 ms / freq;
	-- test signals
	signal   clk   : std_logic := '1';
	signal   nrst  : std_logic;
	signal   t     : std_logic;
	signal   q, nq : std_logic;
begin 
	-- generate clock signal
	clk <= not clk after cycle/2;
	-- instantiate module
	uut : entity work.tff(behavioral)
	      port map(Clk => clk, nRst => nrst, T => t, Q => q, nQ => nq);
	-- apply signals
	process is
	begin
		nrst <= '0'; wait for 1.3*cycle;
		nrst <= '1';
		t <= '1'; wait for cycle;
		t <= '0'; wait for cycle;
		t <= '1'; wait for cycle;
		t <= '0'; wait for cycle;
		wait;
	end process;
end sim;


