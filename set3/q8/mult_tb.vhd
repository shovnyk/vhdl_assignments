-- mult_tb.vhd: Testbench to test the signed multiplier module 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult_tb is
end mult_tb;

architecture sim of mult_tb is

	constant N			  : integer				   := 4;
	constant freq		  : integer				   := 100e6;
	constant cycle 		  : time				   := 1000 ms / freq;

	signal   clock 		  : std_logic			   := '1';
	signal   reset 		  : std_logic			   := '1';
	signal   multiplicand : signed(N downto 1)     := "1001"; -- = -7 in 2's complement
	signal   multiplier   : signed(N downto 1)     := "0011"; -- = 3
	signal   product      : signed(2*N downto 1);
	signal   valid        : std_logic;
	signal   state_out    : std_logic_vector(1 downto 0);

begin

	clock <= not clock after cycle/2;

	--  instantiate an 8-bit signed multiplier module
	uut : entity work.mult(booth)
		  generic map(N => N)
		  port map(multiplicand => multiplicand,
				   multiplier   => multiplier,
			       clock        => clock,
			       reset        => reset,
				   product      => product,
				   valid        => valid,
			       state_out    => state_out);

	process begin
		wait for 0.3*cycle;					-- reset for less than a cycle
		reset <= '0'; wait for 2*N*cycle;	-- then bring dut out of reset
		wait;
	end process;

end sim;
