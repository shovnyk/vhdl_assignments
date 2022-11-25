designfile=adder_subtractor

wave: clean $(designfile).vcd
	gtkwave $(designfile).vcd

$(designfile).vcd: modules $(designfile).vhd $(designfile)_tb.vhd
	ghdl -a $(designfile).vhd
	ghdl -a $(designfile)_tb.vhd
	ghdl -e $(designfile)_tb
	ghdl -r $(designfile)_tb --vcd=$(designfile).vcd

modules: fa.vhd
	ghdl -a fa.vhd
	
clean:
	@rm -vf *.cf *.vcd
