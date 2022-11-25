-- shift_left_right.vhd: Module to implement a 3-bit shift left/right shift register
-- (code for a universal shift register)

library ieee;
use ieee.std_logic_1164.all;

entity shift_left_right is
	generic(N : natural := 3);
	port(CLK      : in  std_logic;								-- clock
		 clear_b  : in  std_logic;								-- active low clear signal
		 s1		  : in  std_logic;								-- shift left line
		 s0       : in  std_logic;								-- shift right line
		 sin	  : in  std_logic;								-- serial input shift left
		 I		  : in  std_logic_vector(N-1 downto 0);			-- input bits
		 A		  : out std_logic_vector(N-1 downto 0));
end shift_left_right;

architecture behavioral of shift_left_right is
	signal data : std_logic_vector(N-1 downto 0);
	signal sel  : std_logic_vector(1 downto 0);
begin
	process(CLK, clear_b) is
	begin
		if clear_b = '0' then
			data <= (others => '0');
		elsif rising_edge(CLK) then
			if s1 = '0' and s0 = '0' then		-- hold
					null;
			elsif s1 = '0' and s0 = '1' then	-- shift right (1 bit)
					for j in 1 to N-1 loop
						data(j-1) <= data(j);
					end loop;
			elsif s1 = '1' and s0 = '0' then	-- shift left (1 bit)
					data(0) <= sin;
					for j in 0 to N-2 loop
						data(j+1) <= data(j);
					end loop;
			elsif s1 = '1' and s0 = '1' then	-- parllel load
					data <= I;
			end if;
		end if;
	end process;
	A <= data;
end behavioral;
