wave: worst_delay.vcd
	@gtkwave worst_delay.vcd

worst_delay.vcd: module worst_delay_tb.vhd
	@ghdl -a worst_delay_tb.vhd
	@ghdl -e worst_delay_tb
	@ghdl -r worst_delay_tb --vcd=worst_delay.vcd

module: submodule worst_delay.vhd
	@ghdl -a worst_delay.vhd

submodule: fa.vhd
	@ghdl -a fa.vhd

clean:
	rm -vf *.cf *.vcd
