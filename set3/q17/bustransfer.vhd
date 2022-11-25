-- bustransfer.vhd: Module to implement the bus based data transfer shown in the diagram

library ieee;
use ieee.std_logic_1164.all;

entity bustransfer is
	port(D1_IN  : in  std_logic_vector(7 downto 0);
		 D2_IN  : in  std_logic_vector(7 downto 0);
		 SEL	: in  std_logic;
		 CLK	: in  std_logic;
		 LDA	: in  std_logic;
		 LDB	: in  std_logic;
		 REG_A  : out std_logic_vector(7 downto 0);
		 REG_B  : out std_logic_vector(7 downto 0));
end bustransfer;

architecture behavioral of bustransfer is
	signal RA, RB : std_logic_vector(7 downto 0);
	signal x	  : std_logic_vector(7 downto 0);
begin
	x <= D1_IN when SEL = '0' else
		 D2_IN when SEL = '1' else
		 (others => 'X');

	process(CLK) begin
		if rising_edge(CLK) then
			if LDA = '1' then
				RA <= x;
			end if;
			if LDB = '1' then
				RB <= x;
			end if;
		end if;
	end process;

	REG_A <= RA;
	REG_B <= RB;
end behavioral;
