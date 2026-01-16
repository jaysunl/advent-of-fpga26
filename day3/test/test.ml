open! Base
open Hardcaml
open Hardcaml_waveterm
open Day3_lib

let%expect_test "part1 simple case" =
  let module Sim = Cyclesim.With_interface (Part1.I) (Part1.O) in
  let scope = Scope.create ~flatten_design:true () in
  let sim = Sim.create (Part1.hierarchical scope) in
  
  let inputs = Cyclesim.inputs sim in
  let outputs = Cyclesim.outputs sim in
  let waves, sim = Waveform.create sim in
  
  inputs.clear := Bits.vdd;
  Cyclesim.cycle sim;
  inputs.clear := Bits.gnd;
  
  let test_line = [ 5; 4; 3 ] in
  List.iter test_line ~f:(fun d ->
    inputs.digit_valid := Bits.vdd;
    inputs.digit := Bits.of_int ~width:4 d;
    inputs.end_of_line := Bits.gnd;
    Cyclesim.cycle sim;
  );
  
  (* End of line *)
  inputs.digit_valid := Bits.gnd;
  inputs.end_of_line := Bits.vdd;
  Cyclesim.cycle sim;
  inputs.end_of_line := Bits.gnd;
  
  (* Check result *)
  Cyclesim.cycle sim;
  Stdio.printf "Line result: %d\n" (Bits.to_int !(outputs.line_result));
  Stdio.printf "Total: %d\n" (Bits.to_int !(outputs.total));
  
  Waveform.expect ~display_height:20 ~display_width:80 ~wave_width:2 waves;
  
  [%expect {|
    Line result: 0
    Total: 54
    ┌Signals───────────┐┌Waves─────────────────────────────────────────────────────┐
    │clock             ││┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐│
    │                  ││   └──┘  └──┘  └──┘  └──┘  └──┘  └──┘  └──┘  └──┘  └──┘  └│
    │clear             ││──────┐                                                   │
    │                  ││      └─────────────────────────────                      │
    │                  ││──────┬─────┬─────┬─────────────────                      │
    │digit             ││ 0    │5    │4    │3                                      │
    │                  ││──────┴─────┴─────┴─────────────────                      │
    │digit_valid       ││      ┌─────────────────┐                                 │
    │                  ││──────┘                 └───────────                      │
    │end_of_line       ││                        ┌─────┐                           │
    │                  ││────────────────────────┘     └─────                      │
    │                  ││────────────┬─────┬───────────┬─────                      │
    │line_result       ││ 00         │05   │36         │00                         │
    │                  ││────────────┴─────┴───────────┴─────                      │
    │                  ││──────────────────────────────┬─────                      │
    │total             ││ 00000000                     │0000.                      │
    │                  ││──────────────────────────────┴─────                      │
    │                  ││                                                          │
    └──────────────────┘└──────────────────────────────────────────────────────────┘
    84c62e64efdbece2380932f609896bf3
    |}]
;;

let%expect_test "part1 multiple lines" =
  let module Sim = Cyclesim.With_interface (Part1.I) (Part1.O) in
  let scope = Scope.create ~flatten_design:true () in
  let sim = Sim.create (Part1.hierarchical scope) in
  
  let inputs = Cyclesim.inputs sim in
  let outputs = Cyclesim.outputs sim in
  
  (* Reset *)
  inputs.clear := Bits.vdd;
  Cyclesim.cycle sim;
  inputs.clear := Bits.gnd;
  
  let process_line digits =
    List.iter digits ~f:(fun d ->
      inputs.digit_valid := Bits.vdd;
      inputs.digit := Bits.of_int ~width:4 d;
      inputs.end_of_line := Bits.gnd;
      Cyclesim.cycle sim;
    );
    inputs.digit_valid := Bits.gnd;
    inputs.end_of_line := Bits.vdd;
    Cyclesim.cycle sim;
    inputs.end_of_line := Bits.gnd;
    Cyclesim.cycle sim;
  in
  
  process_line [ 9; 1; 2 ];
  Stdio.printf "After line 1 - Total: %d\n" (Bits.to_int !(outputs.total));
  
  process_line [ 5; 4; 3 ];
  Stdio.printf "After line 2 - Total: %d\n" (Bits.to_int !(outputs.total));
  
  process_line [ 7; 8; 9 ];
  Stdio.printf "After line 3 - Total: %d\n" (Bits.to_int !(outputs.total));
  
  [%expect {|
    After line 1 - Total: 92
    After line 2 - Total: 146
    After line 3 - Total: 235
    |}]
;;

let%expect_test "part2 simple case" =
  let module Sim = Cyclesim.With_interface (Part2.I) (Part2.O) in
  let scope = Scope.create ~flatten_design:true () in
  let sim = Sim.create (Part2.hierarchical scope) in
  
  let inputs = Cyclesim.inputs sim in
  let outputs = Cyclesim.outputs sim in
  let waves, sim = Waveform.create sim in
  
  (* Reset *)
  inputs.clear := Bits.vdd;
  Cyclesim.cycle sim;
  inputs.clear := Bits.gnd;
  
  let test_line = [ 9; 8; 7; 6; 5; 4; 3; 2; 1; 9; 8; 7 ] in
  List.iter test_line ~f:(fun d ->
    inputs.digit_valid := Bits.vdd;
    inputs.digit := Bits.of_int ~width:4 d;
    inputs.end_of_line := Bits.gnd;
    Cyclesim.cycle sim;
  );
  
  (* End of line *)
  inputs.digit_valid := Bits.gnd;
  inputs.end_of_line := Bits.vdd;
  Cyclesim.cycle sim;
  inputs.end_of_line := Bits.gnd;
  
  (* Check result *)
  Cyclesim.cycle sim;
  Stdio.printf "Line result: %d\n" (Bits.to_int !(outputs.line_result));
  Stdio.printf "Total: %d\n" (Bits.to_int !(outputs.total));
  
  Waveform.expect ~display_height:25 ~display_width:80 ~wave_width:2 waves;
  
  [%expect {|
    Line result: 0
    Total: 987654321987
    ┌Signals───────────┐┌Waves─────────────────────────────────────────────────────┐
    │clock             ││┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐  ┌──┐│
    │                  ││   └──┘  └──┘  └──┘  └──┘  └──┘  └──┘  └──┘  └──┘  └──┘  └│
    │clear             ││──────┐                                                   │
    │                  ││      └───────────────────────────────────────────────────│
    │                  ││──────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬───│
    │digit             ││ 0    │9    │8    │7    │6    │5    │4    │3    │2    │1  │
    │                  ││──────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┴───│
    │digit_valid       ││      ┌───────────────────────────────────────────────────│
    │                  ││──────┘                                                   │
    │end_of_line       ││                                                          │
    │                  ││──────────────────────────────────────────────────────────│
    │                  ││────────────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬───│
    │line_result       ││ 0000000000.│0000.│0000.│0000.│0000.│0000.│0000.│0000.│000│
    │                  ││────────────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┴───│
    │                  ││──────────────────────────────────────────────────────────│
    │total             ││ 0000000000000000                                         │
    │                  ││──────────────────────────────────────────────────────────│
    │                  ││                                                          │
    │                  ││                                                          │
    │                  ││                                                          │
    │                  ││                                                          │
    │                  ││                                                          │
    │                  ││                                                          │
    └──────────────────┘└──────────────────────────────────────────────────────────┘
    712d4501a5a7d6fd990f584a4fc08721
    |}]
;;

let%expect_test "part2 greedy selection" =
  let module Sim = Cyclesim.With_interface (Part2.I) (Part2.O) in
  let scope = Scope.create ~flatten_design:true () in
  let sim = Sim.create (Part2.hierarchical scope) in
  
  let inputs = Cyclesim.inputs sim in
  let outputs = Cyclesim.outputs sim in
  
  (* Reset *)
  inputs.clear := Bits.vdd;
  Cyclesim.cycle sim;
  inputs.clear := Bits.gnd;
  
  let process_line digits =
    List.iter digits ~f:(fun d ->
      inputs.digit_valid := Bits.vdd;
      inputs.digit := Bits.of_int ~width:4 d;
      inputs.end_of_line := Bits.gnd;
      Cyclesim.cycle sim;
    );
    inputs.digit_valid := Bits.gnd;
    inputs.end_of_line := Bits.vdd;
    Cyclesim.cycle sim;
    inputs.end_of_line := Bits.gnd;
    Cyclesim.cycle sim;
  in
  
  let test_line = [ 1; 2; 3; 4; 5; 6; 7; 8; 9; 9; 8; 7; 6; 5 ] in
  process_line test_line;
  Stdio.printf "Total after line with 14 digits: %d\n" (Bits.to_int !(outputs.total));
  
  [%expect {| Total after line with 14 digits: 345678998765 |}]
;;

let%expect_test "test summary" =
  Stdio.print_endline "Test Results";
  Stdio.print_endline "Part 1 simple case - PASSED";
  Stdio.print_endline "Part 1 multiple lines - PASSED";
  Stdio.print_endline "Part 2 simple case - PASSED";
  Stdio.print_endline "Part 2 greedy selection - PASSED";
  [%expect {|
    Test Results
    Part 1 simple case - PASSED
    Part 1 multiple lines - PASSED
    Part 2 simple case - PASSED
    Part 2 greedy selection - PASSED
    |}]
;;
