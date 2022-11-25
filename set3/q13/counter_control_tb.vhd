-- counter_control_tb.vhd: Testbench to test the counter module
-- todo: finish this

library ieee;
use ieee.std_logic_1164.all;

entity counter_control_tb is
end counter_control_tb;

architecture sim of counter_control_tb is
	constant cycle : time := 10 ns;
	signal   clk   : std_logic := '1';
	signal   rst   : std_logic;
	signal   CTRL  : std_logic;
begin
	clk <= not clk after cycle/2;
	uut : entity work.counter_control(behavioral)
		  port map(clk => clk, rst => rst, CTRL => CTRL);
	process begin -- reset the device, then bring it out of reset
		rst <= '1'; wait for 0.3*cycle;
		rst <= '0'; wait for 16*cycle; 
		wait;
	end process;
end sim;
