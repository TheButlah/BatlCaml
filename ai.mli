open Api

(* A single AI tick. This will be implemented by the player, and will use
 * functions from api.mli *)
val step : Api.bot -> Api.command
