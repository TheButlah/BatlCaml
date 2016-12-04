open Bot
open Bullet

(* type of the game state *)
type t

(* static datastructure holding the state *)
val state : t

(* initializes the game state *)
val init : (Bot.t -> Bot.command) list -> int -> float -> float -> float -> float -> 
												 float -> float -> float -> float -> unit

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

(* returns maximum bot power *)
val getMaxPower : unit -> float

(* executes a command returned by the step function *)
val execute : Bot.t -> Bot.command -> Bot.t

(* handles collisions between bots and bullets *)
val handleCollisions : unit -> unit

(* adjusts bot positions if they are outside the game *)
val adjustBotPositions : unit -> unit

(* destroys bullets if they are outside the game *)
val adjustBullets : unit -> unit

(* returns true if the game is finished *)
val finished : unit -> bool
