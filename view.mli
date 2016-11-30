(* type of datastructure maintained by the view *)
type t

(* print out the informations *)
val printInfo : t -> unit

(* print out the logs *)
val outputLog : t -> unit

(* entry point for program *)
val main : unit -> unit
