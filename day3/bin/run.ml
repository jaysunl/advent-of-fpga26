open! Base
open Hardcaml
open Hardcaml_waveterm
open Day3_lib

let parse_input filename =
  let lines = Stdio.In_channel.read_lines filename in
  List.filter_map lines ~f:(fun line ->
    let line = String.strip line in
    if String.is_empty line then None
    else Some (String.to_list line |> List.map ~f:(fun c -> Char.to_int c - 48))
  )
;;

let simulate_part1 lines =
  let module Sim = Cyclesim.With_interface (Part1.I) (Part1.O) in
  let scope = Scope.create ~flatten_design:true () in
  let sim = Sim.create (Part1.hierarchical scope) in
  
  let inputs = Cyclesim.inputs sim in
  let outputs = Cyclesim.outputs sim in
  let waves, sim = Waveform.create sim in
  
  inputs.clear := Bits.vdd;
  Cyclesim.cycle sim;
  inputs.clear := Bits.gnd;
  
  List.iter lines ~f:(fun digits ->
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
  );
  
  for _ = 1 to 5 do
    inputs.digit_valid := Bits.gnd;
    inputs.end_of_line := Bits.gnd;
    Cyclesim.cycle sim;
  done;
  
  let result = Bits.to_int !(outputs.total) in
  Stdio.print_endline (Printf.sprintf "Part 1 Result: %d" result);
  
  Waveform.expect ~display_height:30 ~display_width:100 ~wave_width:2 waves;
  
  result
;;

let simulate_part2 lines =
  let module Sim = Cyclesim.With_interface (Part2.I) (Part2.O) in
  let scope = Scope.create ~flatten_design:true () in
  let sim = Sim.create (Part2.hierarchical scope) in
  
  let inputs = Cyclesim.inputs sim in
  let outputs = Cyclesim.outputs sim in
  let waves, sim = Waveform.create sim in
  
  inputs.clear := Bits.vdd;
  Cyclesim.cycle sim;
  inputs.clear := Bits.gnd;
  
  List.iter lines ~f:(fun digits ->
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
  );
  
  for _ = 1 to 5 do
    inputs.digit_valid := Bits.gnd;
    inputs.end_of_line := Bits.gnd;
    Cyclesim.cycle sim;
  done;
  
  let result = Bits.to_int !(outputs.total) in
  Stdio.print_endline (Printf.sprintf "Part 2 Result: %d" result);
  
  Waveform.expect ~display_height:30 ~display_width:100 ~wave_width:2 waves;
  
  result
;;

let () =
  let args = Sys.get_argv () in
  if Array.length args <> 3 then (
    Stdio.eprintf "Usage: %s <input_file> <part>\n" args.(0);
    Stdlib.exit 1
  );
  
  let filename = args.(1) in
  let part = Int.of_string args.(2) in
  let lines = parse_input filename in
  
  match part with
  | 1 -> ignore (simulate_part1 lines : int)
  | 2 -> ignore (simulate_part2 lines : int)
  | _ -> 
      Stdio.eprintf "Invalid part: %d (must be 1 or 2)\n" part;
      Stdlib.exit 1
;;
