open Bot

(* type of datastructure maintained by the api *)
type handle

(* command type variant *)
type command

(* rotates the bot left *)
val turnLeft : float -> command

(* rotates the bot right *)
val turnRight : float -> command

(* shoots a bullet *)
val shoot : unit -> command

(* moves forward *)
val forward : float -> command

(* does nothing *)
val noCommand : unit -> command

(* returns health of self *)
val getHealth : handle -> float

(* returns position of self *)
val getPos : handle -> float * float

(* returns direction of self *)
val getDirection : handle -> float * float

(* returns speed of self *)
val getSpeed : handle -> float

(* get the (length,width) of room *)
val getRoomSize : unit -> int * int
