open! Base
open Hardcaml
open Day3_lib

let ensure_verilog_dir () =
  if not (Stdlib.Sys.file_exists "verilog") then
    Stdlib.Sys.mkdir "verilog" 0o755
;;

let generate_part1 () =
  let module Circuit = Circuit.With_interface (Part1.I) (Part1.O) in
  let scope = Scope.create ~flatten_design:true () in
  let circuit = Circuit.create_exn ~name:"part1" (Part1.hierarchical scope) in
  ensure_verilog_dir ();
  Rtl.output ~output_mode:(To_file "verilog/part1.v") Verilog circuit;
  Stdio.print_endline "Generated verilog/part1.v"
;;

let generate_part2 () =
  let module Circuit = Circuit.With_interface (Part2.I) (Part2.O) in
  let scope = Scope.create ~flatten_design:true () in
  let circuit = Circuit.create_exn ~name:"part2" (Part2.hierarchical scope) in
  ensure_verilog_dir ();
  Rtl.output ~output_mode:(To_file "verilog/part2.v") Verilog circuit;
  Stdio.print_endline "Generated verilog/part2.v"
;;

let () =
  let args = Sys.get_argv () in
  if Array.length args <> 2 then (
    Stdio.eprintf "Usage: %s <part>\n" args.(0);
    Stdlib.exit 1
  );
  
  let part = Int.of_string args.(1) in
  match part with
  | 1 -> generate_part1 ()
  | 2 -> generate_part2 ()
  | _ -> 
      Stdio.eprintf "Invalid part: %d (must be 1 or 2)\n" part;
      Stdlib.exit 1
;;
