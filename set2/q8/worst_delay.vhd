-- worst_delay.vhd: Module to find the worst delay for a ripple carry adders

library ieee;
use ieee.std_logic_1164.all;

-- create a generic N bit adder
entity rca is
	generic(nbits : integer);
	port(
			-- inputs
			A	 : in std_logic_vector(nbits-1 downto 0);
			B	 : in std_logic_vector(nbits-1 downto 0);

			-- outputs
			S	 : out std_logic_vector(nbits-1 downto 0);
			Cout : out std_logic
		);
end rca;

architecture structural of rca is

	signal carry : std_logic_vector(nbits-1 downto 0);

begin

	rca_nbit : for i in 0 to (nbits-1) generate

		fa0 : if i = 0 generate
			bit0 : entity work.fa(dataflow)
				   port map(A	 => A(i),
							B	 => B(i),
					    	S	 => S(i),
							Cin	 => '0',
							Cout => carry(i));
		end generate fa0;

		fax : if i /= 0 generate
			bitx : entity work.fa(dataflow)
				   port map(A	 => A(i),
							B	 => B(i),
					    	S	 => S(i),
							Cin	 => carry(i-1),
							Cout => carry(i));
		end generate fax;

	end generate rca_nbit;

	Cout <= carry(nbits-1);

end structural;
