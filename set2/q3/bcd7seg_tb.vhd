-- bcd7seg_tb.vhd: Testbench to test the working of the BCD to 7 Segment Decoder

library ieee;
use ieee.std_logic_1164.all;

entity bcd7seg_tb is
end bcd7seg_tb;

architecture sim of bcd7seg_tb is

	-- declare a component for the module to be tested
	component bcd7seg is
		port(X : in std_logic_vector(3 downto 0);
			 Y : out std_logic_vector(6 downto 0));
	end component;

	-- stimulus signals
	signal tX : std_logic_vector(3 downto 0);
	signal tY1 : std_logic_vector(6 downto 0);
	signal tY2 : std_logic_vector(6 downto 0);

begin

	uut1 : entity work.bcd7seg(dataflow)
		   port map(X => tX, Y => tY1);

	uut2 : entity work.bcd7seg(behavioral)
		   port map(X => tX, Y => tY2);

	process is
	begin
		tX <= x"0"; wait for 10 ns;
		tX <= x"1"; wait for 10 ns;
		tX <= x"2"; wait for 10 ns;
		tX <= x"3"; wait for 10 ns;
		tX <= x"4"; wait for 10 ns;
		tX <= x"5"; wait for 10 ns;
		tX <= x"6"; wait for 10 ns;
		tX <= x"7"; wait for 10 ns;
		tX <= x"8"; wait for 10 ns;
		tX <= x"9"; wait for 10 ns;
		wait;
	end process;

end sim;
