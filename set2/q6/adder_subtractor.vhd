-- adder_subtractor.vhd: Module to implement a 12 bit unsigned adder/subtractor.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_subtractor is
	generic(N : integer := 12);
	port(	-- inputs
			x	 : in unsigned(N-1 downto 0);
			y	 : in unsigned(N-1 downto 0);
			mode : in std_logic;
			-- outputs
			ov   : out std_logic;			-- addition overflow/subtraction underflow
			S	 : out unsigned(N-1 downto 0));
end entity;

architecture behavioral of adder_subtractor is
	component fa is
		port(A, B, Cin : in  std_logic;
		       S, Cout : out std_logic);
	end component;
	signal carry, yM : std_logic_vector(N-1 downto 0);
begin
	-- ripple carry adder/subtractor logic with mode select
	addsub : for i in 0 to N-1 generate
			 begin
				 bit0 : if i = 0 generate
					 yM(i) <= y(i) xor mode;
					 fa0 : fa port map(A	=> x(i),
									   B	=> yM(i),
									   Cin	=> mode,
									   S	=> S(i),
								       Cout => carry(i));
				 end generate bit0;
				 bitX : if i /= 0 generate
					 yM(i) <= y(i) xor mode;
					 faX : fa port map(A	=> x(i),
									   B	=> yM(i),
									   Cin	=> carry(i-1),
								       S	=> S(i),
								       Cout => carry(i));
				 end generate bitX;
	end generate addsub;

	ov <= carry(N-1);

end behavioral;
