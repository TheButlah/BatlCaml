open Bot

(* open Bullet *)

type t

val state : t

(* The type representing a bot handle (like a pointer to a bot object) 
type handle = int *)

(* initializes the game state *) 
val init : (Bot.t -> Bot.command) list -> int -> float -> unit

(* steps the game one frame *)
val step : unit -> unit

(* TODO:
(* returns the list of bullets currently in the game *)
val getBullets : t -> Bullet.t list
*)

(* returns the list of bots currently in the game *)
val getBots : unit -> Bot.t list

(* returns width of the room *)
val getWidth : unit -> float

(* returns height of the room *)
val getHeight : unit -> float
