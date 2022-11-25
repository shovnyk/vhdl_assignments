-- parity_check.vhd: Module to implement an even parity checker module 
-- for an N bit number + parity bit

library ieee;
use ieee.std_logic_1164.all;

entity parity_check is
	generic(N : integer);
	port(stream  : in  std_logic_vector(N downto 0);
	       check : out std_logic);
end parity_check;

architecture dataflow of parity_check is
	signal data : std_logic_vector(N downto 0);
begin
	-- even parity: check is high when number of 1s is odd
	XORGATE : for i in 0 to N-1 generate
		bit0 : if i = 0 generate
			check <= stream(i) xor stream(i + 1);
		end generate bit0;
		bitX : if i /= 0 generate
			check <= data(i) xor stream(i + 1);
		end generate bitX;
	end generate XORGATE;
	check <= data(N-1);
end dataflow;
