-- n_input_gate_tb.vhd : Testbench to test the modules for 6 distinct N-input gates

library ieee;
use ieee.std_logic_1164.all;

entity n_input_gate_tb is
end n_input_gate_tb;

architecture sim of n_input_gate_tb is

	-- define the number of bits
	constant nbits		 : integer := 8;

	-- declare common test signals for all the gates
	signal	 input		 : std_logic_vector(nbits-1 downto 0);
	signal	 output_AND  : std_logic;
	signal	 output_OR   : std_logic;
	signal	 output_NAND : std_logic;
	signal	 output_NOR  : std_logic;
	signal	 output_XOR  : std_logic;
	signal	 output_XNOR : std_logic;

begin
	-- instantiate different types of N input gates using their architecture
	and_n  : entity work.n_input_gate(and_gate)
			 generic map(N => nbits)
			 port map(input => input, output => output_AND);

	or_n   : entity work.n_input_gate(or_gate)
			 generic map(N => nbits)
			 port map(input => input, output => output_OR);

	nand_n  : entity work.n_input_gate(nand_gate)
			 generic map(N => nbits)
			 port map(input => input, output => output_NAND);

	nor_n : entity work.n_input_gate(nor_gate)
			 generic map(N => nbits)
			 port map(input => input, output => output_NOR);

	xor_n : entity work.n_input_gate(xor_gate)
			 generic map(N => nbits)
			 port map(input => input, output => output_XOR);

	xnor_n : entity work.n_input_gate(xnor_gate)
			 generic map(N => nbits)
			 port map(input => input, output => output_XNOR);

	-- apply common inputs to all the gates and observe their outputs
	stimulus: process is
	begin
		-- try to cover as many important test cases in as few inputs as possible
		input <= x"00"; wait for 10 ns;  -- all zeros
		input <= x"FF"; wait for 10 ns;	 -- all ones
		input <= x"01"; wait for 10 ns;  -- all except 1 zeros
		input <= x"80"; wait for 10 ns;  -- all except 1 zeros nibbles reversed
		input <= x"7F"; wait for 10 ns;	 -- all except 1 ones
		input <= x"F7"; wait for 10 ns;	 -- all except 1 ones nibbles reversed
		input <= x"AA"; wait for 10 ns;  -- even number of ones
		input <= x"E0"; wait for 10 ns;  -- odd number of ones 
		wait;
	end process;
end sim;
