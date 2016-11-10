(* type of datastructure maintained by the api *)
type t

(* rotates the bot left *)
val turnLeft : t -> t

(* rotates the bot right *)
val turnRight : t -> t

(* moves some number of units in the x direction *)
val moveX : int -> t -> t

(* moves some number of units in the y direction *)
val moveY : int -> t -> t

(* shoots a bullet *)
val shoot : t -> t

(* returns health of bot *)
val getHealth : t -> float

(* returns enemy x position *)
val otherX : t -> int

(* returns enemy y position *)
val otherY : t -> int

(* returns enemy health *)
val otherHealth : t -> float