-- ringcounter_tb.vhd: Testbench for testing ring counter

library ieee;
use ieee.std_logic_1164.all;

entity ringcounter_tb is
end ringcounter_tb;

architecture sim of ringcounter_tb is
	constant cycle : time := 10 ns;
	signal CLK : std_logic := '0';
	signal ORI : std_logic;
	signal Y   : std_logic_vector(2 downto 0);
begin
	CLK <= not CLK after cycle/2;
	uut : entity work.ringcounter(behavioral) 
	      port map(CLK => CLK, ORI => ORI, Y => Y);
	process begin
		ORI <= '0'; wait for 1.3*cycle;
		ORI <= '1'; wait for 6*cycle;
		wait;
	end process;
end sim;
