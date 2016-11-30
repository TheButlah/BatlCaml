type command = 
  | LT of float
  | RT of float
  | Shoot
  | Forward of float
  | Wait

(* The type of a bot *)
type t

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

(* Gets id of the bot *)
val getID : t -> int

(* Gets the step function of the bot *)
val getStepFunc : t -> (t -> command) 

(* Gets the radius of the bot *)
val getRadius : t -> float

(* Sets the Position of the bot *)
val setPosition : float * float -> t -> t

(* Sets the Direction of the bot*)
val setDirection : float * float -> t -> t

(* Moves the bot forward by a constant amount*)
val moveForward : float -> t -> t

(* Set the power level of the bot *)
val setPower : float -> t -> t

(* Makes a new bot with a given position, direction, power level, and max speed.
 * Also assigns the ai step function to the bot.
 * [make (xPos,yPos) (xVec,yVec) power maxSpeed radius stepAI] *)
val make :  (float * float) -> 
            (float * float) -> 
            float -> 
            float -> 
            float ->
            (t -> command) -> 
            t
