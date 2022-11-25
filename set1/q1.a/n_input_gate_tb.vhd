-- n_input_gate_tb.vhd : Testbench to test the modules for 6 distinct N-input gates

library ieee;
use ieee.std_logic_1164.all;

entity n_input_gate_tb is
end n_input_gate_tb;

architecture sim of n_input_gate_tb is

	-- define the number of bits
	constant nbits1		 : natural := 8;		-- even number of bits
	constant nbits2		 : natural := 3;		-- odd number of bits

	-- declare common test signals for all the gates
	signal	 input1		  : std_logic_vector(nbits1-1 downto 0);
	signal   input2       : std_logic_vector(nbits2-1 downto 0);
	signal	 output1_AND  : std_logic;
	signal	 output1_OR   : std_logic;
	signal	 output1_NAND : std_logic;
	signal	 output1_NOR  : std_logic;
	signal	 output1_XOR  : std_logic;
	signal	 output1_XNOR : std_logic;

	signal   output2_XOR  : std_logic;
	signal   output2_XNOR : std_logic; 

begin
	-- instantiate different types of N input gates using their architecture
	and_n1	:	entity work.n_input_gate(and_gate)
				generic map(N => nbits1)
				port map(input => input1, output => output1_AND);

	or_n1	:	entity work.n_input_gate(or_gate)
				generic map(N => nbits1)
				port map(input => input1, output => output1_OR);

	nand_n1	:	entity work.n_input_gate(nand_gate)
				generic map(N => nbits1)
				port map(input => input1, output => output1_NAND);

	nor_n1	:	entity work.n_input_gate(nor_gate)
				generic map(N => nbits1)
				port map(input => input1, output => output1_NOR);

	xor_n1	:	entity work.n_input_gate(xor_gate)
				generic map(N => nbits1)
				port map(input => input1, output => output1_XOR);

	xnor_n1	:	entity work.n_input_gate(xnor_gate)
				generic map(N => nbits1)
			 	port map(input => input1, output => output1_XNOR);

	-- apply common inputs to all the gates and observe their outputs
	stimulus1 : process is
	begin
		-- try to cover as many important test cases in as few inputs as possible
		input1 <= x"00"; wait for 10 ns;  -- all zeros
		input1 <= x"FF"; wait for 10 ns;	 -- all ones
		input1 <= x"01"; wait for 10 ns;  -- all except 1 zeros
		input1 <= x"80"; wait for 10 ns;  -- all except 1 zeros nibbles reversed
		input1 <= x"7F"; wait for 10 ns;	 -- all except 1 ones
		input1 <= x"F7"; wait for 10 ns;	 -- all except 1 ones nibbles reversed
		input1 <= x"AA"; wait for 10 ns;  -- even number of ones
		input1 <= x"E0"; wait for 10 ns;  -- odd number of ones 
		wait;
	end process stimulus1;

	xor_n2	:	entity work.n_input_gate(xor_gate)
				generic map(N => nbits2)
				port map(input => input2, output => output2_XOR);

	xnor_n2	:	entity work.n_input_gate(xnor_gate)
				generic map(N => nbits2)
				port map(input => input2, output => output2_XNOR);

	-- test xor and xnor for odd number of bits (in 3 bit binary ie octal)
	stimulus2 : process is
	begin
		input2 <= O"0"; wait for 10 ns;
		input2 <= O"1"; wait for 10 ns;
		input2 <= O"2"; wait for 10 ns;
		input2 <= O"3"; wait for 10 ns;
		input2 <= O"4"; wait for 10 ns;
		input2 <= O"5"; wait for 10 ns;
		input2 <= O"6"; wait for 10 ns;
		input2 <= O"7"; wait for 10 ns;
		wait;
	end process stimulus2;
end sim;
