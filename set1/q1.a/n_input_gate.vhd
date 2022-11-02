-- n_input_gate.vhd: Module to implement 6 basic logic gates with N bit inputs

library ieee;
use ieee.std_logic_1164.all;

entity n_input_gate is
	generic(N   : integer); -- make number of bits a generic
	port(input  : in  std_logic_vector(N-1 downto 0);
		 output : out std_logic);
end n_input_gate;

-- 1. N input AND Gate
architecture and_gate of n_input_gate is

	-- internal signal for holding intermediate stages of propagation
	signal data : std_logic_vector(N-2 downto 0);

begin

	-- loop through the input and perform repeated AND operation
	GATE : for i in 0 to N-2 generate
		
		BIT0: if (i = 0) generate
			data(i) <= input(i) and input(i+1);
		end generate BIT0;

		BITX: if (i /= 0) generate
			data(i) <= data(i-1) and input(i+1);
		end generate BITX;

	end generate GATE;

	-- data propagates to the output
	output <= data(N-2);

end and_gate;

-- 2. N input OR Gate
architecture or_gate of n_input_gate is
	signal data : std_logic_vector(N-2 downto 0);
begin
	GATE : for i in 0 to N-2 generate
		BIT0: if (i = 0) generate
			data(i) <= input(i) or input(i+1);
		end generate BIT0;
		BITX: if (i /= 0) generate
			data(i) <= data(i-1) or input(i+1);
		end generate BITX;
	end generate GATE;
	output <= data(N-2);
end or_gate;

-- 3. N input NAND Gate
architecture nand_gate of n_input_gate is
	signal data : std_logic_vector(N-2 downto 0);
begin
	GATE : for i in 0 to N-2 generate
		BIT0: if (i = 0) generate
			data(i) <= (not input(i)) or (not input(i+1));
		end generate BIT0;
		BITX: if (i /= 0) generate
			data(i) <= data(i-1) or (not input(i+1));
		end generate BITX;
	end generate GATE;
	output <= data(N-2);
end nand_gate;

-- 4. N input NOR Gate
architecture nor_gate of n_input_gate is
	signal data : std_logic_vector(N-2 downto 0);
begin
	GATE : for i in 0 to N-2 generate
		BIT0: if (i = 0) generate
			data(i) <= (not input(i)) and (not input(i+1));
		end generate BIT0;
		BITX: if (i /= 0) generate
			data(i) <= data(i-1) and (not input(i+1));
		end generate BITX;
	end generate GATE;
	output <= data(N-2);
end nor_gate;

-- 5. N input XOR Gate
architecture xor_gate of n_input_gate is
	signal data : std_logic_vector(N-2 downto 0);
begin
	GATE : for i in 0 to N-2 generate
		BIT0: if (i = 0) generate
			data(i) <= input(i) xor input(i+1);
		end generate BIT0;
		BITX: if (i /= 0) generate
			data(i) <= data(i-1) xor input(i+1);
		end generate BITX;
	end generate GATE;
	output <= data(N-2);
end xor_gate;

-- 6. N input XNOR Gate
architecture xnor_gate of n_input_gate is
	signal data : std_logic_vector(N-2 downto 0);
begin
	GATE : for i in 0 to N-2 generate
		BIT0: if (i = 0) generate
			data(i) <= input(i) xnor input(i+1);
		end generate BIT0;
		BITX: if (i /= 0) generate
			data(i) <= data(i-1) xnor input(i+1);
		end generate BITX;
	end generate GATE;
	output <= data(N-2);
end xnor_gate;
