-- ram16x8.vhd: Module to implement a 16 word 8 bit RAM

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram16x8 is
	port(
			address		: in	std_logic_vector(3 downto 0); -- 16 words = 4 addr bits
			data_in		: in	std_logic_vector(7 downto 0); -- 8 bits / 1 word
			rdwr		: in	std_logic;					  -- 1 = read, 0 = write
			clock		: in	std_logic;
			data_out	: out	std_logic_vector(7 downto 0)  -- output bus
		);
end ram16x8;

architecture behavioral of ram16x8 is
	-- memory can be syntheized from arrays: define new type for creating RAM from array
	-- define a type for a 16x8 bit memory
	type memory is array (0 to 15) of std_logic_vector(7 downto 0);
	-- initial values of words in the ram
	signal ram : memory := (
		x"00", x"11", x"22", x"33", -- 0x00 to 0x03
		x"44", x"55", x"66", x"77", -- 0x04 to 0x07
		x"88", x"99", x"AA", x"BB", -- 0x08 to 0x0B
		x"CC", x"DD", x"EE", x"FF"  -- 0x0C to 0x0F
	);
	-- define function acting as 3 bit decoder
	function decode(addr3bit : in std_logic_vector(3 downto 0)) return integer is
	begin
		return to_integer(unsigned(addr3bit));
	end function;
begin
	process(clock) is
	begin
		if rising_edge(clock) then	-- at clock edge sample, the read/write signal
			if rdwr = '1' then		-- read operation
				data_out <= ram(decode(address));
			elsif rdwr = '0' then	-- write operation
				ram(decode(address)) <= data_in;
			end if;
		end if;
	end process;
end behavioral;
