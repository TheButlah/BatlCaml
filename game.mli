open Bot
open Api
(* open Bullet *)

type t

(* The type representing a bot handle (like a pointer to a bot object) 
type handle = int *)

val make : unit -> t

(* steps the game one frame *)
val step : t -> t

(*
(* returns the list of bullets currently in the game *)
val getBullets : t -> Bullet.t list
*)

(* returns the list of bots currently in the game *)
val getBots : t -> Bot.t list

(* returns width of the room *)
val getWidth : t -> int

(* returns height of the room *)
val getHeight : t -> int

