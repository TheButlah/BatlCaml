open Api

(* A single AI tick. This will be implemented by the player, and will use
 * functions from api.mli *)
val step : Bot.t -> Bot.command

val step2 : Bot.t -> Bot.command
