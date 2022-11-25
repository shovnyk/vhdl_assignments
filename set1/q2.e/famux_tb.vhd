-- famux_tb.vhd: Testbench to test the full adder using mux implementation
library ieee;
use ieee.std_logic_1164.all;

entity famux_tb is
end famux_tb;

architecture sim of famux_tb is
	signal A, B, Cin : std_logic;
	signal S, Cout	 : std_logic;
begin 
	uut : entity work.famux(structural)
		  port map(
					A	 => A,
					B	 => B,
					Cin  => Cin,
					Cout => Cout,
					S	 => S
				  );
	process begin
		A <= '0'; B <= '0'; Cin <= '0'; wait for 10 ns;
		A <= '0'; B <= '0'; Cin <= '1'; wait for 10 ns;
		A <= '0'; B <= '1'; Cin <= '0'; wait for 10 ns;
		A <= '0'; B <= '1'; Cin <= '1'; wait for 10 ns;
		A <= '1'; B <= '0'; Cin <= '0'; wait for 10 ns;
		A <= '1'; B <= '0'; Cin <= '1'; wait for 10 ns;
		A <= '1'; B <= '1'; Cin <= '0'; wait for 10 ns;
		A <= '1'; B <= '1'; Cin <= '1'; wait for 10 ns;
		wait;
	end process;
end sim;
