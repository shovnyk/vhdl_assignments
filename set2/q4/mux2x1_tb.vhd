-- mux2x1_tb.vhd: Testbench for verification of 3-bit 2 to 1 MUX

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2x1_tb is
end mux2x1_tb;

architecture sim of mux2x1_tb is

	-- declare component of the 2x1 MUX
	component mux2x1 is 
		port(in0, in1 : in unsigned(2 downto 0);
				  sel : in std_logic;
					y : out unsigned(2 downto 0));
	end component;

	-- test signals for stimulus
	signal t_in0, t_in1 : unsigned(2 downto 0);
	signal t_sel		: std_logic;

	-- test signals for response
	signal t_y			: unsigned(2 downto 0);

begin

	-- instantiate component
	uut : mux2x1 port map(in0 => t_in0, in1 => t_in1, sel => t_sel, y => t_y);

	-- apply stimulus
	process is
	begin
		t_sel <= '0'; t_in0 <= "000"; t_in1 <= "111"; wait for 10 ns;
		t_sel <= '0'; t_in0 <= "001"; t_in1 <= "111"; wait for 10 ns;
		t_sel <= '0'; t_in0 <= "010"; t_in1 <= "111"; wait for 10 ns;
		t_sel <= '0'; t_in0 <= "100"; t_in1 <= "111"; wait for 10 ns;

		t_sel <= '1'; t_in0 <= "000"; t_in1 <= "111"; wait for 10 ns;
		t_sel <= '1'; t_in0 <= "000"; t_in1 <= "110"; wait for 10 ns;
		t_sel <= '1'; t_in0 <= "000"; t_in1 <= "101"; wait for 10 ns;
		t_sel <= '1'; t_in0 <= "000"; t_in1 <= "011"; wait for 10 ns;
		wait;
	end process;
end sim;
