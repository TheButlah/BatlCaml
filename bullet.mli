(* type of a bullet *)
type t

(* gets the position of the bullet *)
val getPosition : t -> float * float

(* gets direction of the bullet *)
val getDirection : t -> float * float

(* gets speed of the bullet *)
val getSpeed : t -> float

(* gets id of the bullet *)
val getID : t -> int

(* gets power of the bullet *)
val getPower : t -> float

(* creates a bullet with (x, y) (xdir, ydir) speed power id *)
val make : float * float -> float * float -> float -> float -> int -> t

(* steps the bullet *)
val step : t -> t