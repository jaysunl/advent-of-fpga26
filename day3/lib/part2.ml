open! Base
open Hardcaml
open Signal

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; digit_valid : 'a
    ; digit : 'a [@bits 4]
    ; end_of_line : 'a
    }
  [@@deriving sexp_of, hardcaml]
end

module O = struct
  type 'a t =
    { total : 'a [@bits 64]
    ; line_result : 'a [@bits 48]
    }
  [@@deriving sexp_of, hardcaml]
end

let create (i : Signal.t I.t) =
  let spec = Reg_spec.create ~clock:i.clock ~clear:i.clear () in
  
  let best_wires = List.init 12 ~f:(fun _idx -> Signal.wire 48) in
  
  let best_regs = List.mapi best_wires ~f:(fun idx _wire ->
    let width = 48 in
    Signal.reg_fb spec ~enable:vdd ~width ~f:(fun prev ->
      if idx = 0 then
        let updated = Signal.mux2 
          (i.digit_valid &: (Signal.uresize i.digit width >: prev))
          (Signal.uresize i.digit width)
          prev
        in
        Signal.mux2 i.end_of_line (zero width) updated
      else
        let prev_best = List.nth_exn best_wires (idx - 1) in
        let ten = of_int ~width 10 in
        let prod = Signal.uresize (prev_best *: ten) width in
        let candidate = prod +: Signal.uresize i.digit width in
        let updated = Signal.mux2
          (i.digit_valid &: (candidate >: prev))
          candidate
          prev
        in
        Signal.mux2 i.end_of_line (zero width) updated
    )
  ) in
  
  List.iter2_exn best_wires best_regs ~f:(fun wire reg ->
    Signal.assign wire reg
  );
  
  let line_result = List.last_exn best_regs in
  
  let total = Signal.reg_fb spec ~enable:i.end_of_line ~width:64 ~f:(fun prev ->
    prev +: Signal.uresize line_result 64
  ) in
  
  { O.total; line_result }
;;

let hierarchical scope i =
  let module H = Hierarchy.In_scope (I) (O) in
  H.hierarchical ~scope ~name:"part2" (fun _scope -> create) i
;;
