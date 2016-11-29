open Bot

(* rotates the bot left *)
val turnLeft : float -> Bot.command

(* rotates the bot right *)
val turnRight : float -> Bot.command

(* shoots a bullet *)
val shoot : unit -> Bot.command

(* moves forward *)
val forward : float -> Bot.command

(* does nothing *)
val noCommand : unit -> Bot.command

(* returns health of self *)
val getHealth : Bot.handle -> float

(* returns position of self *)
val getPos : Bot.handle -> float * float

(* returns direction of self *)
val getDirection : Bot.handle -> float * float

(* returns speed of self *)
val getSpeed : Bot.handle -> float

(* get the (length,width) of room *)
val getRoomSize : unit -> int * int

