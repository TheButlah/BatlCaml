(* type of command returned by ai step function *)
type command

(* The type of a bullet *)
type bullet

(* The type of a bot *)
type t

(* room size *)
val roomSize : (int * int) ref

(* Gets the Position of the bot 
 * returns A 2D Tuple of the position in x,y *)
val getPosition : t -> float * float

(* Gets the Direction of the bot
 * returns A 2D Tuple of the direction in x,y *)
val getDirection : t -> float * float

(* Gets the maximum speed of the bot *)
val getMaxSpeed : t -> float

(* Get the power level of the bot *)
val getPower : t -> float

(* Sets the Position of the bot *)
val setPosition : t -> float * float -> t 

(* Sets the Direction of the bot*)
val setDirection : t -> float * float -> t

(* Moves the bot forward by a constant amount*)
val moveForward : t -> float -> t

(* Set the power level of the bot *)
val setPower : t -> float -> t

(* Makes a new bot with a given position, direction, and power level.
 * Also assigns the ai step function to the bot.
 * [make (xPos,yPos) (xVec,yVec) power stepAI] *)
val make : (float * float) -> (float * float) -> float -> (t -> command) -> t

(* Updates a bot for a single logic tick *)
val step : t -> t
