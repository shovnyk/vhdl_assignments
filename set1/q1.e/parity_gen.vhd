-- parity_gen.vhd: Module to implement an N bit even parity generator

library ieee;
use ieee.std_logic_1164.all;

entity parity_gen is
	generic(N : integer);
	port(A : in  std_logic_vector(N-1 downto 0);
		 P : out std_logic);
end parity_gen;

architecture dataflow of parity_gen is
	signal D : std_logic_vector(N-1 downto 0);
begin
	XORGATE : for i in 0 to N-2 generate
		BIT0: if (i = 0) generate
			D(i) <= A(i) xor A(i+1);
		end generate BIT0;
		BITX: if (i /= 0) generate
			D(i) <= D(i-1) xor A(i+1);
		end generate BITX;
	end generate XORGATE;
	P <= D(N-2);
end dataflow;
