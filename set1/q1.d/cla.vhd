-- cla.vhd: Module to create a 4-bit Carry Look Ahead Adder

library ieee;
use ieee.std_logic_1164.all;

entity cla is
	generic(N : integer := 4);
	port( -- inputs
		  A    : in  std_logic_vector(N-1 downto 0);
	      B    : in  std_logic_vector(N-1 downto 0);
		  -- outputs
		  S    : out std_logic_vector(N-1 downto 0);
		  Cout : out std_logic);
end cla;

architecture dataflow of cla is

	signal carry : std_logic_vector(N-1 downto 0); -- intermediate carry stages
	signal P	 : std_logic_vector(N-1 downto 0); -- carry propagate
	signal G	 : std_logic_vector(N-1 downto 0); -- carry generate

begin

	Adder: for i in 0 to N-1 generate

		P(i) <= A(i) xor B(i);
		G(i) <= A(i) and B(i);

		bit0 : if (i = 0) generate
			S(i)	 <= P(i) xor '0';
			carry(i) <= G(i) or (P(i) and '0');
		end generate bit0;

		bitX : if (i /= 0) generate
			S(i)	 <= P(i) xor carry(i-1);
			carry(i) <= G(i) or (P(i) and carry(i-1));
		end generate bitX;

	end generate Adder;

	Cout <= carry(N-1);

end dataflow;
