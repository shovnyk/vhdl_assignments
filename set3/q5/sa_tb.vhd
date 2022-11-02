-- sa_tb.vhd: Testbench to test the N-bit serial adder module

library ieee;
use ieee.std_logic_1164.all;

entity sa_tb is
end sa_tb;

architecture sim of sa_tb is

	constant nbits  : integer := 8;
	constant freq   : integer := 100e6;
	constant period : time	  := 1000 ms / freq;
	
	signal   clk    : std_logic := '1';
	signal   nrst   : std_logic;
	signal   ov		: std_logic;
	signal   a		: std_logic_vector(nbits-1 downto 0);
	signal   b		: std_logic_vector(nbits-1 downto 0);
	signal   sum	: std_logic_vector(nbits-1 downto 0);

	-- test input vectors
	constant ntests : integer := 5;
	type vector_list is array(0 to ntests-1) of std_logic_vector(nbits-1 downto 0);
	signal operandA : vector_list := (x"01", x"68", x"AA", x"FE", x"FF");
	signal operandB : vector_list := (x"02", x"47", x"11", x"25", x"FF");

begin

	uut : entity work.sa(behavioral)
		  generic map(nbits => nbits)
		  port map(Clk  => clk,
				   nRst => nrst,
				   A	=> a,
				   B	=> b,
				   Sum  => sum,
			       Ov   => ov);

	-- generate clock signal
	clk <= not clk after period/2;

	-- apply stimulus to test device (try out a vareity of 
	process is
		variable i : integer := 0;
	begin

		nrst <= '0'; wait for 1.3*period;
		nrst <= '1';
		a	 <= operandA(i);
		b	 <= operandB(i);
		wait for nbits*period;

		wait until rising_edge(clk);
		
		if i = ntests-1 then
			wait;
		else
			i := i + 1;
		end if;

	end process;

end sim;
