-- one_counter.vhd: Module to count the number of ones in a 16 bit binary number

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity one_counter is
	generic(nbits : integer);
	port(	
			-- inputs
			reset : in std_logic;
			clock : in std_logic;
			input : in std_logic; -- binary number as bit stream

			-- outputs: 16 bit binary number: maximum 16 1's so need 4 bits to hold count
			--			this number will be specified via generic at instantiation
			count : inout unsigned(nbits-1 downto 0)
		);
end one_counter;

architecture behavioral of one_counter is
begin
	process(clock, reset) is 
	begin
		if reset = '1' then
			count <= (others => '0');
		elsif rising_edge(clock) then
			if input = '1' then
				count <= count + 1;
			end if;
		end if;
	end process;
end behavioral;
