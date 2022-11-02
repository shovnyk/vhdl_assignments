-- adder_subtractor.vhd: Module to implement a 4 bit adder subtractor

library ieee;
use ieee.std_logic_1164.all;

entity adder_subtractor is
	generic(nbits : integer := 4);
	port(	-- inputs
			M    : in  std_logic;							-- mode select bit
			A    : in  std_logic_vector(nbits-1 downto 0);	-- operand 1
			B    : in  std_logic_vector(nbits-1 downto 0);	-- operand 2
		
			-- outputs
			S    : out std_logic_vector(nbits-1 downto 0);	-- sum bits
			Cout : out std_logic;							-- output carry/borrow
			Ov	 : out std_logic							-- overflow detection
			-- todo: what is the overflow bit actually doing (mano, page: 182, fig:4.13)
		);
end adder_subtractor;

architecture dataflow of adder_subtractor is
	signal carry : std_logic_vector(nbits-1 downto 0);
begin
	AddSub : for i in 0 to nbits-1 generate
		bit0 : if (i = 0) generate
			S(i)	 <= A(i) xor (B(i) xor M) xor M;
			carry(i) <= (M and (A(i) xor (B(i) xor M))) or (A(i) and (B(i) xor M));
		end generate bit0;
		bit1 : if (i /= 0) generate
			S(i)	 <= A(i) xor (B(i) xor M) xor carry(i-1);
			carry(i) <= (carry(i-1) and (A(i) xor (B(i) xor M)))
						or (A(i) and (B(i) xor M));
		end generate bit1;
	end generate AddSub;
	Cout <= carry(nbits-1);
	Ov   <= carry(nbits-1) xor carry(nbits-2);
end dataflow;
