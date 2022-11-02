designfile=gray2bin

wave: clean $(designfile).vcd
	gtkwave $(designfile).vcd

$(designfile).vcd: $(designfile).vhd $(designfile)_tb.vhd
	ghdl -s $(designfile).vhd
	ghdl -s $(designfile)_tb.vhd
	ghdl -a $(designfile).vhd
	ghdl -a $(designfile)_tb.vhd
	ghdl -e $(designfile)_tb
	ghdl -r $(designfile)_tb --vcd=$(designfile).vcd

clean:
	@rm -vf *.cf *.vcd
