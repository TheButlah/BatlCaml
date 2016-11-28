open Bot

(* type of datastructure maintained by the api *)
type t = BotHandler.t

(* representation of self information *)
type self

(* representation of the enemy's information *)
type enemy

(* rotates the bot left *)
val turnLeft : float -> t -> t

(* rotates the bot right *)
val turnRight : float -> t -> t

(* sets speed *)
val setSpeed : float -> t -> t

(* shoots a bullet *)
val shoot : t -> t

(* returns health of self *)
val getHealth : self -> float

(* returns position of self *)
val getPos : self -> (float * float)

(* returns direction of self *)
val getDirection : self -> (float * float)

(* returns speed of self *)
val getSpeed : self -> float

(* get the (length,width) of room *)
val getRoomSize : t -> (int * int)

(* returns enemy position *)
val enemyPosition : enemy -> (float * float)

(* returns enemy velocity *)
val enemyVelocity : enemy -> (float * float)

(* returns enemy health *)
val enemyHealth : enemy -> float
