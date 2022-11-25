-- ram16x8_tb.vhd: Testbench to test the 16 word 8 bit RAM

library ieee;
use ieee.std_logic_1164.all;

entity ram16x8_tb is
end ram16x8_tb;

architecture sim of ram16x8_tb is
	constant cycle  : time	:= 10 ns;
	signal address	: std_logic_vector(3 downto 0);
	signal data_in	: std_logic_vector(7 downto 0);
	signal rdwr		: std_logic;
	signal clock	: std_logic := '1';
	signal data_out	: std_logic_vector(7 downto 0);
begin
	clock <= not clock after cycle/2;
	uut : entity work.ram16x8(behavioral)
		  port map(
					address => address,
					data_in	=> data_in,
					rdwr	=> rdwr,
					clock	=> clock,
					data_out => data_out
				  );
	process begin
		wait for 0.3*cycle;
		-- read contents of the RAM
		rdwr	<= '1';
		address <= "0000"; wait for cycle;
		address <= "0010"; wait for cycle;
		address <= "0101"; wait for cycle;
		address <= "1010"; wait for cycle;

		-- write contents into the RAM
		rdwr	<= '0';
		address <= "0000"; data_in <= x"FF"; wait for cycle;
		address <= "0010"; data_in <= x"EE"; wait for cycle;
		address <= "0101"; data_in <= x"22"; wait for cycle;
		address <= "1010"; data_in <= x"55"; wait for cycle;

		-- read contents of the RAM
		rdwr <= '1';
		address <= "0000"; wait for cycle;
		address <= "0010"; wait for cycle;
		address <= "0101"; wait for cycle;
		address <= "1010"; wait for cycle;
		wait;
	end process;
end sim;
