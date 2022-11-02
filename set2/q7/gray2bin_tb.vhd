-- gray2bin_tb.vhd: Testbench for the 4 bit Gray Code to Binary Converter Module

library ieee;
use ieee.std_logic_1164.all;

entity gray2bin_tb is
end gray2bin_tb;

architecture sim of gray2bin_tb is

	-- declare component for the module
	component gray2bin is
		port(gray : in std_logic_vector(3 downto 0);
			  bin : out std_logic_vector(3 downto 0));
	end component;

	-- test signals
	signal t_gray : std_logic_vector(3 downto 0) := x"0";
	signal t_bin  : std_logic_vector(3 downto 0);

begin

	-- instantiate unit under test
	uut : gray2bin port map(gray => t_gray, bin => t_bin);

	-- process to apply stimulus
	process is
	begin
		t_gray <= x"0"; wait for 10 ns;
		t_gray <= x"1"; wait for 10 ns;
		t_gray <= x"2"; wait for 10 ns;
		t_gray <= x"3"; wait for 10 ns;
		t_gray <= x"4"; wait for 10 ns;
		t_gray <= x"5"; wait for 10 ns;
		t_gray <= x"6"; wait for 10 ns;
		t_gray <= x"7"; wait for 10 ns;
		t_gray <= x"8"; wait for 10 ns;
		t_gray <= x"9"; wait for 10 ns;
		t_gray <= x"A"; wait for 10 ns;
		t_gray <= x"B"; wait for 10 ns;
		t_gray <= x"C"; wait for 10 ns;
		t_gray <= x"D"; wait for 10 ns;
		t_gray <= x"E"; wait for 10 ns;
		t_gray <= x"F"; wait for 10 ns;
		wait;
	end process;

end sim;
