open Bot

(* player and enemy handles *)
val player : handle ref
val enemy : handle ref

(* type of datastructure maintained by the api *)
type handle = BotHandler.handle

(* set handles of player and enemy *)
val initPlayer : handle -> unit
val initEnemy : handle -> unit

(* rotates the bot left *)
val turnLeft : handle -> unit

(* rotates the bot right *)
val turnRight : handle -> unit

(* sets speed *)
val setSpeed : handle -> unit

(* shoots a bullet *)
val shoot : handle -> unit

(* returns health of self *)
val getHealth : handle -> float

(* returns position of self *)
val getPos : handle -> float * float

(* returns direction of self *)
val getDirection : handle -> float * float

(* returns speed of self *)
val getSpeed : handle -> float

(* get the (length,width) of room *)
val getRoomSize : handle -> int * int

(* returns enemy position *)
val enemyPosition : handle -> float * float

(* returns enemy velocity *)
val enemyVelocity : handle -> float * float

(* returns enemy health *)
val enemyHealth : handle -> float
