-- fa_4bit.vhd: Module to implement a 4 bit full adder

library ieee;
use ieee.std_logic_1164.all;

entity fa_4bit is
	generic(N : integer := 4);
	port(	-- inputs
			A    : in  std_logic_vector(N-1 downto 0);
			B    : in  std_logic_vector(N-1 downto 0);
			-- outputs
			S	 : out std_logic_vector(N-1 downto 0);
			Cout : out std_logic);
end fa_4bit;

architecture dataflow of fa_4bit is

	signal carry : std_logic_vector(N-1 downto 0);

begin
	-- use generate statements in place of structural blocks to produce repeated
	-- concurrent statements implementing ripple carry adder logic
	Adder: for i in 0 to N-1 generate

		bit0: if (i = 0) generate
			S(i)	 <= A(i) xor B(i) xor '0';
			carry(i) <= ('0' and (A(i) xor B(i))) or (A(i) and B(i));
		end generate bit0;

		bitX : if (i /= 0) generate
			S(i)	 <= A(i) xor B(i) xor carry(i-1);
			carry(i) <= (carry(i-1) and (A(i) xor B(i))) or (A(i) and B(i));
		end generate bitX;

	end generate Adder;

	Cout <= carry(N-1);

end dataflow;
