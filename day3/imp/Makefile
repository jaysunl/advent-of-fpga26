.PHONY: all part1 part2 clean

YOSYS = yosys
NEXTPNR = nextpnr-ecp5
ECPPACK = ecppack

all: part1 part2

part1: synth_part1.json
	$(NEXTPNR) --85k --package CABGA381 --json synth_part1.json \
		--lpf constraints.lpf --lpf-allow-unconstrained \
		--textcfg part1.config 2>&1 | tee pnr_part1.log

part2: synth_part2.json
	$(NEXTPNR) --85k --package CABGA381 --json synth_part2.json \
		--lpf constraints.lpf --lpf-allow-unconstrained \
		--textcfg part2.config 2>&1 | tee pnr_part2.log

synth_part1.json: ../verilog/part1.v synth_part1.tcl
	$(YOSYS) -s synth_part1.tcl 2>&1 | tee synth_part1.log

synth_part2.json: ../verilog/part2.v synth_part2.tcl
	$(YOSYS) -s synth_part2.tcl 2>&1 | tee synth_part2.log

bitstream_part1.bit: part1.config
	$(ECPPACK) --compress part1.config bitstream_part1.bit

bitstream_part2.bit: part2.config
	$(ECPPACK) --compress part2.config bitstream_part2.bit

bitstreams: bitstream_part1.bit bitstream_part2.bit

clean:
	rm -f *.json *.config *.bit *.log
