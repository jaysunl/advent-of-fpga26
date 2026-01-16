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
    { total : 'a [@bits 32]
    ; line_result : 'a [@bits 8]
    }
  [@@deriving sexp_of, hardcaml]
end

let create (i : Signal.t I.t) =
  let spec = Reg_spec.create ~clock:i.clock ~clear:i.clear () in
  
  let max_digit = Signal.reg_fb spec ~enable:vdd ~width:4 ~f:(fun prev ->
    let updated = Signal.mux2 (i.digit >: prev) i.digit prev in
    let value = Signal.mux2 i.digit_valid updated prev in
    Signal.mux2 i.end_of_line (zero 4) value
  ) in
  
  let line_max = Signal.reg_fb spec ~enable:vdd ~width:8 ~f:(fun prev ->
    let candidate = 
      let ten = Signal.of_int ~width:8 10 in
      let max_extended = Signal.uresize max_digit 8 in
      let digit_extended = Signal.uresize i.digit 8 in
      let prod = Signal.uresize (max_extended *: ten) 8 in
      prod +: digit_extended
    in
    let updated = Signal.mux2 
      (i.digit_valid &: (candidate >: prev))
      candidate 
      prev 
    in
    Signal.mux2 i.end_of_line (zero 8) updated
  ) in
  
  let total = Signal.reg_fb spec ~enable:i.end_of_line ~width:32 ~f:(fun prev ->
    prev +: Signal.uresize line_max 32
  ) in
  
  { O.total; line_result = line_max }
;;

let hierarchical scope i =
  let module H = Hierarchy.In_scope (I) (O) in
  H.hierarchical ~scope ~name:"part1" (fun _scope -> create) i
;;
