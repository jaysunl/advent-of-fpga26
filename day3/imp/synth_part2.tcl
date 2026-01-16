read_verilog -sv ../verilog/part2.v
synth_ecp5 -json synth_part2.json -top part2 -no-rw-check
stat

