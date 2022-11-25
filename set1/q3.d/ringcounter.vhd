-- ringcounter.vhd: Module to implement a 3 bit ring counter

library ieee;
use ieee.std_logic_1164.all;

entity ringcounter is
	generic(N : natural := 3);
	port(CLK  : in  std_logic; 
		 ORI  : in  std_logic;	-- synchronous active low overriding input
		 Y    : out std_logic_vector(N-1 downto 0));
end ringcounter;

architecture behavioral of ringcounter is
	signal data : std_logic_vector(N-1 downto 0);
begin
	process(CLK, ORI) is
	begin
		if rising_edge(CLK) then
			if ORI = '0' then
				data <= (0 => '1', others => '0'); -- set output to "001"
			else
				data(0) <= data(N-1);
				for i in 0 to N-2 loop
					data(i+1) <= data(i);
				end loop;
			end if;
		end if;
	end process;
	Y <= data;
end behavioral;
