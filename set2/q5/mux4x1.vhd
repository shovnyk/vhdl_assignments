-- mux4x1.vhd: Module design for a 4 to 1 MUX

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4x1 is 
	port(
			-- inputs
			sig0 : in unsigned(5 downto 0);
			sig1 : in unsigned(5 downto 0);
			sig2 : in unsigned(5 downto 0);
			sig3 : in unsigned(5 downto 0);

			-- selector
			sel : in unsigned(1 downto 0);

			-- output
			output : out unsigned(5 downto 0)
		);
end mux4x1;

architecture behavioral of mux4x1 is
begin

	-- concurrent implementation using when-else conditional signal assignment construct
	-- output <= sig0 when sel = "00" else
	-- 		  sig1 when sel = "01" else
	-- 		  sig2 when sel = "10" else
	-- 		  sig3 when sel = "11" else
	-- 		  (others => 'X');

	-- concurrent implementation using with-select conditional signal assignment construct
    -- with sel select
    -- 	output <= sig0 when "00",
    -- 			  sig1 when "01",
    -- 			  sig2 when "10",
    -- 			  sig3 when "11",
    -- 			  (others => 'X') when others;

    -- -- process-based implementation using case-when conditional construct
    -- process(sel, sig0, sig1, sig2, sig3) is
    -- begin
    -- 	case sel is
    -- 		when "00" =>
    -- 			output <= sig0;
    -- 		when "01" =>
    -- 			output <= sig1;
    -- 		when "10" =>
    -- 			output <= sig2;
    -- 		when "11" =>
    -- 			output <= sig3;
    -- 		when others =>
    -- 			output <= (others => 'X');
    -- 	end case;
    -- end process;

    -- process-based implementation using if-then-elsif-else conditional construct
    process(sel, sig0, sig1, sig2, sig3) is
    begin
    	if sel = "00" then
    		output <= sig0;
    	elsif sel = "01" then
    		output <= sig1;
    	elsif sel = "10" then
    		output <= sig2;
    	elsif sel = "11" then
    		output <= sig3;
    	else
    		output <= (others => 'X');
    	end if;
    end process;
end behavioral;
