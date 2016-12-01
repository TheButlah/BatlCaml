open Control
open Format
open Array
open Unix

(* type of datastructure maintained by the view *)
type t

(* print out the informations *)
val printInfo : t -> unit

(* makes screen with information as dots on a printed grid *)
val printScreen : int -> int -> float -> t -> unit

(* print out the logs *)
val outputLog : t -> unit

(* entry point for program *)
val main : unit -> unit
