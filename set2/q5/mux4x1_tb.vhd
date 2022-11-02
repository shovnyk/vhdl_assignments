-- mux4x1_tb.vhd: Testbench for verification of 4 to 1 MUX

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4x1_tb is
end mux4x1_tb;

architecture sim of mux4x1_tb is

	-- declare component of the 4x1 MUX
	component mux4x1 is
		port(sig0, sig1, sig2, sig3 : in unsigned(5 downto 0);
								sel : in unsigned(1 downto 0);
							 output : out unsigned(5 downto 0));
	end component;

	-- test signals for stimulus (initialized to recognizable values)
	signal t_sig0 : unsigned(5 downto 0) := "001010";
	signal t_sig1 : unsigned(5 downto 0) := "001011";
	signal t_sig2 : unsigned(5 downto 0) := "001100";
	signal t_sig3 : unsigned(5 downto 0) := "001101";
	signal t_sel  : unsigned(1 downto 0); 

	-- test signal for response
	signal t_output : unsigned(5 downto 0);

begin

	-- instantiate component
	uut : mux4x1 port map(sig0 => t_sig0,
						  sig1 => t_sig1,
			              sig2 => t_sig2,
			              sig3 => t_sig3,
			               sel => t_sel,
		                output => t_output);

	-- apply stimulus
	process is
	begin
		t_sel <= "00";
		wait for 10 ns;				-- hold select at 00 for 10 ns
		t_sel <= t_sel + 1;
		wait for 10 ns; 			-- hold select at 01 for 10 ns
		t_sel <= t_sel + 1;
		wait for 10 ns;				-- hold select at 10 for 10 ns
		t_sel <= t_sel + 1;
		wait for 10 ns;				-- hold select at 11 for 10 ns
		t_sel <= "UU";
		wait for 10 ns;				-- hold select at unitiliazed state for 10 ns
		wait;						-- terminate process
	end process;

end sim;
