open Bot
open Bullet

(* type of datastructure for stepping the game *)
type t

(* bullet module specific to a bot *)
module Bullet : Bullet

(* bot module assigned to each player *)
module Bot : Bot

(* steps the game one frame *)
val step : t -> t

(* returns the list of bullets currently in the game *)
val getBullets : t -> Bullet.t list

(* returns the list of bots currently in the game *)
val getBots : t -> Bot.t list

(* returns width of the room *)
val getWidth : t -> int

(* returns height of the room *)
val getHeight : t -> int

(* returns score of the game *)
val getScore : t -> int
