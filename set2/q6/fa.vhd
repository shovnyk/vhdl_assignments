-- fa.vhd: Module to implement a single bit Full Adder circuit

library ieee;
use ieee.std_logic_1164.all;

entity fa is
	port(A, B, Cin: in  std_logic; Cout, S: out std_logic);
end fa;

architecture dataflow of fa is
begin
	S <= (A xor B) xor Cin;
	Cout <= (A and B) or ((A xor B) and Cin);
end dataflow;
