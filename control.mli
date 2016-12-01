open Game
open Bot 
open Bullet

(* info for bullets *)
type bulletInfo = {
	x : float;
	y : float;
	dir : float * float;
	owner : int
}

(* info for bots *)
type botInfo = {
	x : float;
	y : float;
	dir : float * float;
	power : float;
	id : int
}

(* type returned by the step function *)
type t = {
	bulletList : bulletInfo list;
	botList : botInfo list;
	finished : bool;
	width : float;
	height : float
}

(* initializes a game *)
val init : int -> unit

(* steps the game and returns a datastructure that can be used for view *)
val step : unit -> t

val registerAI : (Bot.t -> Bot.command) -> unit
