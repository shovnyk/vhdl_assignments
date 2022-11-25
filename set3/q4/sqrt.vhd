-- sqrt.vhd: Module to compute square root of an unsigned number
-- https://sistenix.com/sqrt.html

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sqrt is
	generic(	nbits	  : natural := 8;
				precision : natural := 10
		   );
	port(	A							 : in  unsigned(nbits-1 downto 0);
			clock, reset, oReady, iValid : in  std_logic;
			iReady, oValid				 : out std_logic;
			result						 : inout unsigned(nbits-1 downto 0)
		);
end sqrt;

architecture rtl of sqrt is 
	type state_type is (INIT, SET, CALC, SEND);
	signal state		: state_type;
	signal A_aux, Y, P	: unsigned(2*nbits-1 downto 0);
	signal m			: unsigned(4 downto 0);
begin
	process(clock, reset) is
		variable one	: unsigned(2*nbits-1 downto 0) := (0=>'1', others=>'0');
	begin
		-- asynchronous reset
		if (reset = '1') then
			A_aux	<= (others => '0');
			result	<= (others => '0');
			m		<= to_unsigned(nbits-1, m'length);
			state	<= INIT;
			iReady	<= '0';
			oValid 	<= '0';

		elsif rising_edge(clock) then
			case state is
				when INIT =>
					iReady <= '1';
					oValid <= '0';
					A_aux  <= shift_left(A, precision);
					Y	   <= (others => '0');
					P	   <= (others => '0');
					m	   <= to_unsigned(nbits-1, m'length);
					state  <= SET;

				when SET =>
					if (m < nbits) then
						Y <= shift_left(P, to_integer(m+1)) + 
							 shift_left(one, to_integer(m+m));
						state <= CALC;
					else
						oValid <= '1';
						state <= SEND;
					end if;

				when CALC =>
					if (Y < A_aux or Y = A_aux) then
						A_aux <= A_aux - Y;
						P <= P + shift_left(one, precision-1);
						result(to_integer(m)) <= '1';
					else
						result(to_integer(m)) <= '0';
						m <= m - 1;
						state <= SET;
					end if;

				when SEND => 
					if oReady = '1' then
						result <= shift_right(result, precision-1);
						oValid <= '0';
						state  <= INIT;
					end if;

			end case;
		end if;
	end process;
end rtl;
