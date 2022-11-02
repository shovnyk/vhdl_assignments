-- gray2bin: Module to convert a 4-bit Gray Code to 4-bit Binary Code

library ieee;
use ieee.std_logic_1164.all;

entity gray2bin is
	port(
			gray : in std_logic_vector(3 downto 0);
			 bin : out std_logic_vector(3 downto 0)
		);
end gray2bin;

architecture dataflow of gray2bin is
begin
	-- combinational logic for gray code to binary conversion
	bin(3) <= gray(3);
	bin(2) <= gray(3) xor gray(2);
	bin(1) <= gray(3) xor gray(2) xor gray(1);
	bin(0) <= gray(3) xor gray(2) xor gray(1) xor gray(0);
end dataflow;
