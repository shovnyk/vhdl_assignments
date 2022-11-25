-- decoder3x8.vhd: Module to implement a 3x8 decoder (active high)

library ieee;
use ieee.std_logic_1164.all;

entity decoder3x8 is
	port(input  : in  std_logic_vector(2 downto 0);
		 output : out std_logic_vector(7 downto 0));
end decoder3x8;

architecture behavioral of decoder3x8 is
begin
	process(input) is
	begin
		case input is 
			when "000" =>
				output <= (0 => '1', others => '0');
			when "001" =>
				output <= (1 => '1', others => '0');
			when "010" =>
				output <= (2 => '1', others => '0');
			when "011" =>
				output <= (3 => '1', others => '0');
			when "100" =>
				output <= (4 => '1', others => '0');
			when "101" =>
				output <= (5 => '1', others => '0');
			when "110" =>
				output <= (6 => '1', others => '0');
			when "111" =>
				output <= (7 => '1', others => '0');
			when others =>
				output <= (others => 'X');
		end case;
	end process;
end behavioral;
