read_verilog -sv ../verilog/part1.v
synth_ecp5 -json synth_part1.json -top part1 -no-rw-check
stat

