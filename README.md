# Advent of FPGA Day 3

HardCaml implementation of a digit selection problem. Each line contains a sequence of digits from 1 to 9. Part 1 selects two digits in order to maximize the resulting 2-digit number. Part 2 selects twelve digits to maximize a 12-digit number. The answer is the sum of the maximum values across all lines.

## Prerequisites

- OCaml 4.14 or later
- opam package manager  
- Python 3
- Yosys and NextPNR-ECP5 for FPGA synthesis (optional)

```
cd day3
opam install dune hardcaml hardcaml_waveterm ppx_hardcaml ppx_jane ppx_expect
dune build
```

For FPGA synthesis (optional):
```
brew install yosys nextpnr-ecp5          # macOS
sudo apt-get install yosys nextpnr-ecp5  # Linux
```

Or use OSS CAD Suite from https://github.com/YosysHQ/oss-cad-suite-build

## Running Software Tests

```
python3 day3/software/part1.py day3/data/<txt file>
python3 day3/software/part2.py day3/data/<txt file>
```

## Running Hardware Tests

```
cd day3
dune runtest
```

## Simulations

```
cd day3
dune exec bin/run.exe data/<txt file> 1
dune exec bin/run.exe data/<txt file> 2
```

The first argument is the input file path and the second is the part number.

## Generating Verilog

```
cd day3
dune exec bin/generate.exe 1
dune exec bin/generate.exe 2
```

Output is written to `verilog/part1.v` and `verilog/part2.v`.

## FPGA Implementation
You must generate the Verilog first.

Run synthesis and place-and-route:
```
make part1    # Synthesize Part 1
make part2    # Synthesize Part 2
make all      # Both parts
```

Generate bitstreams:
```
make bitstreams
```

Clean build artifacts:
```
make clean
```

Resource utilization and timing reports are printed directly to the terminal. `.json` files represent the synthesized netlists. `.config` files contain physical implementation results.`.bit` files contain FPGA bitstreams.

## Methodology

The problem asks us to select a subset of digits from each input line to form the largest possible number. For part 1 we select 2 digits and for part 2 we select 12 digits. The digits must remain in their original order.

The Python implementation solves part 1 by scanning the input from right to left. It tracks the maximum digit seen so far and forms candidate pairs by placing each new digit before this maximum. The largest pair found becomes the answer for that line. This works because we want the leftmost digit to be as large as possible, and the rightmost digit should be the maximum of all digits to its right.

Part 2 requires selecting 12 digits from potentially longer sequences. The Python code uses a greedy algorithm with a stack. It iterates through the digits and maintains a monotonically decreasing sequence. When a new digit is larger than the stack top, it removes smaller digits to make room for the larger one. This ensures we get the lexicographically largest subsequence.

The hardware implementation takes a different approach better suited to streaming data. Instead of buffering entire lines, the circuit processes one digit per clock cycle and maintains state registers.

For part 1, the circuit keeps two registers. The first tracks the maximum digit seen in the current line. The second holds the best 2-digit value found so far. Each cycle it forms a new candidate by multiplying the max digit by 10 and adding the current input digit. If this candidate exceeds the stored best value, it updates. When the end_of_line signal arrives, the best value accumulates into a running total and both registers reset for the next line.

Part 2 extends this idea with twelve registers arranged as an array. Register $k$ stores the best $k$-digit number encountered so far in the current line. When a new digit arrives, all registers update in parallel. The first register takes the maximum of itself and the new digit. Each subsequent register computes a candidate by taking the previous register value, multiplying by 10, and adding the new digit. If this candidate exceeds the current value in that register, it updates. At the end of each line, the twelfth register value represents the best 12-digit number and accumulates into the total.

Both circuits use synchronous logic with an active-high clear signal. All register updates happen on the rising clock edge. The design includes multipliers for decimal arithmetic, comparators for selecting maximum values, and multiplexers for conditional updates. There are no combinational loops or latches, making the design suitable for FPGA synthesis.

The following waveform shows part 1 processing the test input "543, 912, 789". Each line produces values 54, 92, and 89 respectively, summing to 235.

```
┌Signals───────────┐┌Waves─────────────────────────────────────────────────────────────────────────┐
│clock             ││┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐  │
│                  ││   └──┘  └──┘  └──┘  └──┘  └──┘  └──┘  └──┘  └──┘  └──┘  └──┘  └──┘  └──┘  └──│
│clear             ││──────┐                                                                       │
│                  ││      └───────────────────────────────────────────────────────────────────────│
│                  ││──────┬─────┬─────┬───────────┬─────┬─────┬───────────┬─────┬─────┬───────────│
│digit             ││ 0    │5    │4    │3          │9    │1    │2          │7    │8    │9          │
│                  ││──────┴─────┴─────┴───────────┴─────┴─────┴───────────┴─────┴─────┴───────────│
│digit_valid       ││      ┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐     │
│                  ││──────┘                 └─────┘                 └─────┘                 └─────│
│end_of_line       ││                        ┌─────┐                 ┌─────┐                 ┌─────│
│                  ││────────────────────────┘     └─────────────────┘     └─────────────────┘     │
│                  ││────────────┬─────┬───────────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────│
│line_result       ││ 00         │05   │36         │00   │09   │5B   │5C   │00   │07   │4E   │59   │
│                  ││────────────┴─────┴───────────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┴─────│
│                  ││──────────────────────────────┬───────────────────────┬───────────────────────│
│total             ││ 00000000                     │00000036               │00000092               │
│                  ││──────────────────────────────┴───────────────────────┴───────────────────────│
│                  ││                                                                              │
│                  ││                                                                              │
│                  ││                                                                              │
│                  ││                                                                              │
│                  ││                                                                              │
│                  ││                                                                              │
│                  ││                                                                              │
│                  ││                                                                              │
│                  ││                                                                              │
│                  ││                                                                              │
│                  ││                                                                              │
└──────────────────┘└──────────────────────────────────────────────────────────────────────────────┘
```

Here, we see that the `line_result` register updates when a new candidate exceeds the current value. For line "543", we see it go to `0x05` (5 decimal) then `0x36` (54 decimal). The value 54 comes from pairing the maximum digit seen (5) with the current digit (4). When digit 3 arrives, it does not produce a better pair than 54. At the `end_of_line` pulse, `line_result` resets to 0 while total accumulates the 54 and becomes `0x36`. This process repeats for subsequent lines, with the total growing to `0x5C` (92) after line "912" and reaching the final sum of 235 after all three lines complete.
