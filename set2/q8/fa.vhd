-- fa.vhd: Module to implement a basic full adder module
library ieee;
use ieee.std_logic_1164.all;

entity fa is
	port(A, B, Cin : in std_logic; S, Cout : out std_logic);
end fa;

architecture dataflow of fa is

	-- introduce propagation delay to see the effects of cascading
	-- in a ripple carry adder that will be constructed out of this.
	constant prop_delay : time := 10 ns;

begin

	S	 <= (A xor B xor Cin)					after prop_delay;
	Cout <= ((Cin and (A xor B)) or (A and B))  after prop_delay;

end architecture;
