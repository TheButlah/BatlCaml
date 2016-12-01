open Bot
open Game
open Control

(* enemy type *)
type enemy = {
	xPos : float;
	yPos : float;
	xDir : float;
	yDir : float;
	speed : float;
	power : float;
	id : int;
}

(* rotates the bot left *)
val turnLeft : float -> Bot.command

(* rotates the bot right *)
val turnRight : float -> Bot.command

(* shoots a bullet *)
val shoot : unit -> Bot.command

(* moves forward *)
val forward : float -> Bot.command

(* does nothing *)
val wait : unit -> Bot.command

(* returns health of self *)
val getHealth : Bot.t -> float

(* returns position of self *)
val getPos : Bot.t -> float * float

(* returns direction of self *)
val getDirection : Bot.t -> float * float

(* returns speed of self *)
val getSpeed : Bot.t -> float

(* returns id of self *)
val getID : Bot.t -> int 

(* get the (length,width) of room *)
val getRoomSize : unit -> float * float

(* gets the enemies of the game and returns a list of them *)
val getEnemies : Bot.t -> enemy list

(* registers the step function so it can be recognized by 
 * the game; must be called at the end of every ai file *)
val register : (Bot.t -> Bot.command) -> unit
