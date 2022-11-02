-- worst_delay_tb.vhd: Testbench to test the ripple carry adder to find worst case delay
-- todo: finish this, ask sayan sir how to proceed

library ieee;
use ieee.std_logic_1164.all;

entity worst_delay_tb is
end worst_delay_tb;

architecture sim of worst_delay_tb is

	-- define the number of bits to instantiate the RCA with
	constant nbits : integer := 4;

	-- signals to test the device with
	signal   A	   : std_logic_vector(nbits-1 downto 0);
	signal	 B	   : std_logic_vector(nbits-1 downto 0);
	signal	 S	   : std_logic_vector(nbits-1 downto 0);
	signal   Cout  : std_logic;

	-- variables to keep track of time elapsed
	signal elapsed : time;

begin

	-- instantiate an RCA module
	rca_nbit : entity work.rca(structural)
			   generic map(nbits => nbits)
			   port map(A    => A,
						B    => B,
						S	 => S,
						Cout => Cout);

	-- apply stimulus
	find_worst_case: process is 
	begin
		A <= x"A"; B <= x"1"; wait for 100 ns;
		A <= x"B"; B <= x"2"; wait for 100 ns;
		A <= x"C"; B <= x"3"; wait for 100 ns;
		A <= x"D"; B <= x"4"; wait for 100 ns;
		wait;
	end process;
	
end sim;
