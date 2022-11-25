designfile=counter_control

wave: $(designfile).vcd
	gtkwave $(designfile).vcd

$(designfile).vcd: clean $(designfile).vhd $(designfile)_tb.vhd
	ghdl -a $(designfile).vhd
	ghdl -a $(designfile)_tb.vhd
	ghdl -e $(designfile)_tb
	ghdl -r $(designfile)_tb --vcd=$(designfile).vcd --stop-time=200ns

clean:
	@rm -vf *.cf *.vcd
