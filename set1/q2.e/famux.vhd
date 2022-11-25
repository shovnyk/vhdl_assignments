-- famux.vhd: Module to implement a Full Adder circuit using 2 8x1 Multiplexers
library ieee;
use ieee.std_logic_1164.all;

entity famux is
	port(A, B, Cin  : in  std_logic;
			S, Cout : out std_logic);
end famux;

architecture structural of famux is
begin

	-- S = m(1, 2, 4, 7)
	mux8_S		: entity work.mux8x1(behavioral) 
				  port map(
							data(0)	=> '0',
							data(1)	=> '1',
							data(2)	=> '1',
							data(3)	=> '0',
							data(4)	=> '1',
							data(5)	=> '0',
							data(6)	=> '0',
							data(7)	=> '1',

							Sel(2)	=> A,
							Sel(1)	=> B,
							Sel(0)	=> Cin,

							Y		=> S
						);

	-- Cout = m(3, 5, 6, 7)
	mux8_Cout	: entity work.mux8x1(behavioral) 
				  port map(
							data(0)	=> '0',
							data(1)	=> '0',
							data(2)	=> '0',
							data(3)	=> '1',
							data(4)	=> '0',
							data(5)	=> '1',
							data(6)	=> '1',
							data(7)	=> '1',

							Sel(2)	=> A,
							Sel(1)	=> B,
							Sel(0)	=> Cin,

							Y		=>	Cout
						);

end structural;
