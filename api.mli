(* type of datastructure maintained by the api *)
type t

type self

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

val getPos : self -> (float * float)

val getDirection : self -> (float * float)

val getSpeed : self -> float

(* get the (length,width) of room *)
val getRoomSize : t -> (int * int)

(* returns enemy position *)
val enemyPosition : enemy -> (float * float)

val enemyVelocity : enemy -> (float * float)

(* returns enemy health *)
val enemyHealth : enemy -> float
