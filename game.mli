open Bot
open Bullet

(* type of the game state *)
type t

(* static datastructure holding the state *)
val state : t

(* initializes the game state *)
val init : (Bot.t -> Bot.command) list -> int -> float -> unit

(* steps the game one frame *)
val step : unit -> unit

(* returns the list of bullets currently in the game *)
val getBullets : unit -> Bullet.t list

(* returns the list of bots currently in the game *)
val getBots : unit -> Bot.t list

(* returns width of the room *)
val getWidth : unit -> float

(* returns height of the room *)
val getHeight : unit -> float

(* executes a command returned by the step function *)
val execute : Bot.t -> Bot.command -> Bot.t

val handleCollisions : unit -> unit
