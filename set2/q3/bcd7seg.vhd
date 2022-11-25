-- bcd7seg.vhd: Module to convert BCD into segments for an ACTIVE LOW 7 segment display

library ieee;
use ieee.std_logic_1164.all;

entity bcd7seg is
	port( X : in std_logic_vector(3 downto 0);
		  Y : out std_logic_vector(6 downto 0));
end bcd7seg;


architecture dataflow of bcd7seg is
begin

	Y(6) <= X(0) or X(2) or (X(1) and X(3)) or ((not X(1)) and (not X(3)));

	Y(5) <= (not X(1)) and ((not X(2)) and (not X(3))) and (X(2) and X(3));
	
	Y(4) <= X(1) or (not X(2)) or X(3);

	Y(3) <= ((not X(1)) and (not X(3))) or (X(2) and (not X(3))) or 
			(X(1) and (not X(2)) and X(3)) or ((not X(1)) and X(2)) or X(0);

	Y(2) <= ((not X(1)) and (not X(3))) or (X(2) and (not X(3)));

	Y(1) <= X(0) or ((not X(2)) and (not X(3))) or (X(1) and (not X(2))) or 
			(X(1) and (not X(3)));

	Y(0) <= X(0) or (X(1) and (not X(2))) or ((not X(1)) and X(2)) or 
			(X(2) and (not X(3)));

end dataflow;

architecture behavioral of bcd7seg is
begin
	process(X) is
	begin
		case X is
			when x"0" =>
				Y <= "0000001"; -- 0
			when x"1" =>
				Y <= "1001111"; -- 1
			when x"2" =>
				Y <= "0010010"; -- 2
			when x"3" =>
				Y <= "0000110"; -- 3
			when x"4" =>
				Y <= "1001100"; -- 4
			when x"5" =>
				Y <= "0100100"; -- 5
			when x"6" =>
				Y <= "0100000"; -- 6
			when x"7" =>
				Y <= "0001111"; -- 7
			when x"8" =>
				Y <= "0000000"; -- 8
			when x"9" =>
				Y <= "0000100"; -- 9
			when others =>
				Y <= (others => 'X');
		end case;
	end process;
end behavioral;

-- todo: correct dataflow model
-- todo: finish structural model
-- todo: behavioral model: check out this post -
--       https://stackoverflow.com/questions/34000296/case-statement-error-message-in-vhdl
