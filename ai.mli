open Api

(* A single AI tick. This will be implemented by the player, and will use
 * functions from api.mli *)
val step1 : Api.handle -> Api.handle -> Api.command

val step2 : Api.handle -> Api.handle -> Api.command
