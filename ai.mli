(* The type of the result of the AI step. Used internally by
 * the rest of the code. This has been abstracted away on purpose. *)
type t

(* A single AI tick. This will be implemented by the player, and will use
 * functions from api.mli *)
val step : t -> t

