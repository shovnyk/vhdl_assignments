-- circuit18.vhd: Module to implement the circuit given in question 18

library ieee;
use ieee.std_logic_1164.all;

entity circuit18 is
	port(  
			-- INPUTS
			DS     : in  std_logic;
	        X,Y,Z  : in  std_logic_vector(7 downto 0);
		    MS	   : in  std_logic_vector(1 downto 0);
		    CLK    : in  std_logic;

		    -- OUTPUTS
		    RB	   : out std_logic_vector(7 downto 0);
		    RA	   : out std_logic_vector(7 downto 0)
		);
end circuit18;

architecture behavioral of circuit18 is

	signal A, B, C  : std_logic_vector(7 downto 0);
	signal LDA, LDB : std_logic;

begin

	-- 1:2 decoder
	LDB <= DS;
	LDA <= not DS;

	-- 4:1 MUX
	A <= X when MS = "11" else
		 Y when MS = "10" else
		 Z when MS = "01" else
		 C when MS = "00";

	-- register sections
	process(CLK) begin
		if falling_edge(CLK) then
			if LDA = '1' then
				B <= A;
			end if;
			if LDB = '1' then
				C <= B;
			end if;
		end if;
	end process;

	-- outputs
	RB <= C;
	RA <= B;

end behavioral;
