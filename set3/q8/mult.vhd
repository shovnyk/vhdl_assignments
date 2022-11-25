-- mult.vhd: Code to implement a Signed Multiplication module.
-- We have decided to use a Booth's multiplier (though a number of other multiplier
-- hardware architectures exist like the Wallace Tree multiplier)


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult is
	generic(N : integer);							-- no of bits
	port(clock		  : in  std_logic;
		 reset		  : in  std_logic;
		 multiplicand : in  signed(N downto 1);		-- multiplicand
		 multiplier   : in  signed(N downto 1);		-- mulitplier
         product	  : out signed(2*N downto 1);	-- product
		 valid		  : out std_logic;				-- product-valid bit
		 state_out    : out std_logic_vector(1 downto 0));
end mult;

architecture booth of mult is

	-- declare abstract states and state variable
	type abstract_state is (idle, addsub, shift, done);
	signal state : abstract_state;

	-- declare internal registers
	signal M     : signed(N downto 1);
	signal Q     : signed(N downto 1);
	signal A	 : signed(N downto 1);					-- accumulator
	signal q0	 : std_logic;							-- control signal
	signal count : integer range N downto 0;			-- counter

begin

	process(clock, reset) is
	begin
		if reset = '1' then
			state <= idle;

		elsif rising_edge(clock) then
			case state is
				when idle =>
					state <= addsub;
				when addsub =>
					state <= shift;
				when shift =>
					if count = 0 then
						state <= done;
					elsif count > 0 then
						state <= addsub;
					end if;
				when done =>
					state <= state; -- do nothing
			end case;
		end if;
	end process;

	process(state) is
	begin
		case state is
			when idle =>
				-- initialize registers and other signals
				M     <= multiplicand;
				Q     <= multiplier;
				A	  <= (others => '0');
				q0    <= '0';
				count <= N;
				valid <= '0';

			when addsub =>
				-- conditionally add/subtract
				if Q(1) = '0' and q0 = '1' then
					A <= A + M;
				elsif Q(1) = '1' and q0 = '0' then
					A <= A - M;
				end if;

			when shift =>
				-- arithmetic shift right by 1 bit
				q0 <= Q(1);
				for i in 1 to N loop
					if i = N then
						Q(i) <= A(1);
					else
						Q(i) <= Q(i + 1);
					end if;
				end loop;
				for i in 1 to N loop
					if i = N then
						A(i) <= A(N);
					else
						A(i) <= A(i + 1);
					end if;
				end loop;
				-- decrement counter
				count <= count - 1;

			when done =>
				-- set valid bit indicating product has been fully computed
				valid <= '1';
		end case;
	end process;

	-- product consists of the two registers A and Q as higher and lower words
	product <= (A & Q);

	-- for testing, check state transitions
	with state select
		state_out <= "00" when idle,
					 "01" when addsub,
					 "10" when shift,
					 "11" when done,
					 "XX" when others;

end booth;
