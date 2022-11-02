-- sa.vhd: Module to implement an N-bit serial adder

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sa is
	generic(nbits : integer);
	port(	-- inputs
			Clk  : in  std_logic;
			nRst : in  std_logic;
			A	 : in  std_logic_vector(nbits-1 downto 0);
			B    : in  std_logic_vector(nbits-1 downto 0);

			-- outputs
			Sum  : out std_logic_vector(nbits-1 downto 0);
			Ov   : out std_logic
		);
end sa;

architecture behavioral of sa is

	-- hold intermediate carry states
	signal carry : std_logic;

begin
	
	-- decribe serial addition action
	process(Clk, nRst) is
		variable i : integer := 0;
	begin
		if nRst = '0' then
			-- reset outputs and bit tracker
			Sum   <= (others => '0');
			carry <= '0';
			i	  :=  0;

		elsif rising_edge(Clk) and (i < nbits) then
			if i = 0 then
				carry <= '0';
			end if;

			-- implement full adder logic
			Sum(i) <= (A(i) xor B(i) xor carry);
			carry  <= (carry and (A(i) xor B(i))) or (A(i) and B(i));

			-- update the bit tracker
			i := i + 1;

		end if;
	end process;

	Ov <= carry;

end architecture;
