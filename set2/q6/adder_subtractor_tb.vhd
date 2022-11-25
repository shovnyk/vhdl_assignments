-- adder_subtractor_tb.vhd: Testbench to test the adder subtractor module with 12 bits

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_subtractor_tb is
end adder_subtractor_tb;

architecture sim of adder_subtractor_tb is
	constant N	  : integer := 12;
	signal	 x	  : unsigned(N-1 downto 0);
 	signal   y	  : unsigned(N-1 downto 0);
	signal   s	  : unsigned(N-1 downto 0);
	signal	 mode : std_logic;
	signal   ov	  : std_logic;
begin
	-- instantiate adder/subtractor module with a 12 bit data bus
	uut : entity work.adder_subtractor(behavioral)
	      generic map(N => N)
		  port map(x => x, y => y, mode => mode, s => s, ov => ov);
	-- apply stimulus
	process is
	begin
		mode <= '0';		-- addition
		x	 <= x"F00";
		y    <= x"F11";
		wait for 10 ns;

		mode <= '1';		-- subtraction
		x	 <= x"8F0";
		y    <= x"9F0";
		wait for 10 ns;
		wait;
	end process;
end sim;
