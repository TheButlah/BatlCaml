type bot = Apiinternal.bot
type command = Apiinternal.command
(* enemy type *)

type enemy = {
	xPos : float;
	yPos : float;
	xDir : float;
	yDir : float;
	speed : float;
	power : float;
	id : int;
	energy : float;
}

(* [turnLeft amt] rotates the bot left by amt degrees *)
val turnLeft : float -> command

(* [turnLeft amt]rotates the bot right by amt degrees *)
val turnRight : float -> command

(* shoots a bullet *)
val shoot : unit -> command

(* moves forward. Requires [amt] of [forward amt] is a float such that
 * 0.0 <= amt <= 1.0 *)
val forward : float -> command

(* does nothing *)
val wait : unit -> command

(* returns energy of self, which should be between 0..100 *)
val getEnergy : bot -> float

(* returns health of self. [getHealth b] returns a float between 0.0 and 100.0
 * where 100.0 is the max bot health *)
val getHealth : bot -> float

(* returns position of self where (0.0,0.0) is the bottom left corner of the 
 * simulation*)
val getPos : bot -> float * float

(* returns direction of self. [getDirection b] returns a unit vector 
 * representing direction such that (1,0) points directly towards the right
 * side of the simulation *)
val getDirection : bot -> float * float

(* returns speed of self *)
val getSpeed : bot -> float

(* returns id of self *)
val getID : bot -> int 

(* get the (length,width) of room *)
val getRoomSize : unit -> float * float

(* gets the enemies of the game and returns a list of them *)
val getEnemies : bot -> enemy list

(* registers the step function so it can be recognized by 
 * the game; must be called at the end of every ai file *)
val register : (bot -> command) -> unit
