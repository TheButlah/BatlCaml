module type AI = sig
  type t
  val step : t -> t
end

module type Bot = sig

  (* The t:ype of a bot *)
  type t

  (* Gets the Position of the bot 
   * returns A 2D Tuple of the position in x,y *)
  val getPosition : t -> float * float

  (* Gets the Direction of the bot
   * returns A 2D Tuple of the direction in x,y *)
  val getDirection : t -> float * float

  (* Gets the Speed of the bot *)
  val getSpeed : t -> float

  (* Get the power level of the bot *)
  val getPower : t -> float

  (* Makes a new bot with a given position, direction, and power level
   * [make (xPos,yPos) (xVec,yVec) power] *)
  val make : (float * float) -> (float * float) -> float -> t

  (* Updates the bot for a single logic tick *)
  val step : t -> t
end


module type MakeBot =
  functor (A : AI) -> Bot

module MakeBot : MakeBot
