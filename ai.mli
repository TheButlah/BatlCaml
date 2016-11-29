open Api

(* A single AI tick. This will be implemented by the player, and will use
 * functions from api.mli *)
val step1 : Bot.handle -> Bot.handle -> Bot.command

val step2 : Bot.handle -> Bot.handle -> Bot.command
