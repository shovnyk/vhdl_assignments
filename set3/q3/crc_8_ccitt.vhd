-- crc.vhd: Module to implement a CRC generator using the CRC-8-CCITT scheme
-- for which the generator polynomial is G(x) = x^8 + x^7 + x^3 + x^2 + x^1 + 1

library ieee;
use ieee.std_logic_1164.all;

entity crc_8_ccitt is
	port(DIN  : in std_logic;
		 CLK  : in std_logic;
		 CRC  : out std_logic_vector(7 downto 0);
		 VOUT : out std_logic);
end crc_8_ccitt;

architecture rtl of crc_8_ccitt is
	signal D	  : std_logic_vector(7 downto 0) := (others => '0');
	signal Q	  : std_logic_vector(7 downto 0) := (others => '0');
	signal count  : integer := 0;
begin
	-- reset register or shift the data into flip flops at every clock edge
	shift : process(CLK) begin
		if rising_edge(CLK) and (count < 16) then
			for i in 0 to 7 loop
				Q(i) <= D(i);
			end loop;
			count <= count + 1;
		end if;
	end process shift;

	-- flip data bits conditionally at locations determined by the generator polynomial
	process(Q, DIN) begin
		for i in 0 to 7 loop
			case i is
				when 0 => D(0) <= DIN  xor Q(7);
				when 2 => D(2) <= Q(1) xor Q(7);
				when 3 => D(3) <= Q(2) xor Q(7);
				when 7 => D(7) <= Q(6) xor Q(7);
				when others => D(i) <= Q(i-1);
			end case;
		end loop;
	end process;

	-- make the Q register available as the bits of the output CRC
	CRC <= Q;

	-- indicate when the output is valid
	VOUT <= '1' when count = 16 else '0';

end rtl;
