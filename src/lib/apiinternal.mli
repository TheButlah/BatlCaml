type bot = Bot.t
type command = Bot.command

(* enemy type *)
type enemy = {
	xPos : float;
	yPos : float;
	xDir : float;
	yDir : float;
	speed : float;
	power : float;
	id : int;
	energy : float
}

(* rotates the bot left *)
val turnLeft : float -> command

(* rotates the bot right *)
val turnRight : float -> command

(* shoots a bullet *)
val shoot : unit -> command

(* moves forward *)
val forward : float -> command

(* does nothing *)
val wait : unit -> command

(* returns energy of self *)
val getEnergy : bot -> float

(* returns health of self *)
val getHealth : bot -> float

(* returns position of self *)
val getPos : bot -> float * float

(* returns direction of self *)
val getDirection : bot -> float * float

(* returns maximum speed of self *)
val getMaxSpeed : bot -> float

(* returns the speed of bullets *)
val getBulletSpeed : unit -> float

(* returns id of self *)
val getID : bot -> int 

(* get the (length,width) of room *)
val getRoomSize : unit -> float * float

(* gets the enemies of the game and returns a list of them *)
val getEnemies : bot -> enemy list

(* registers the step function so it can be recognized by 
 * the game; must be called at the end of every ai file *)
val register : (bot -> command) -> unit
