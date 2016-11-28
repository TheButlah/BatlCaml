module type AI = sig
  type t
  val step : t -> t
end

module type Bot = sig

  (* The type of a bot *)
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


module AI = struct

end

module MakeBot (A : AI) = struct

  (* The type of a bot *)
  type t = {
    xPos : float;
    yPos : float;
    xDir : float;
    yDir : float;
    speed : float;
    power : float;
  }

  (* Gets the Position of the bot 
   * returns A 2D Tuple of the position in x,y *)
  let getPosition t =
    (t.xPos, t.yPos)

  (* Gets the Direction of the bot
   * returns A 2D Tuple of the direction in x,y *)
  let getDirection t = 
    (t.xDir, t.yDir)

  (* Gets the Speed of the bot *)
  let getSpeed t =
    t.speed

  (* Get the power level of the bot *)
  let getPower t =
    t.power

  (* Makes a new bot with a given position, direction, and power level
   * [make (xPos,yPos) (xVec,yVec) power] *)
  let make (xPos,yPos) (xVec,yVec) power = {
    xPos = xPos;
    yPos = yPos;
    xDir = xVec;
    yDir = yVec;
    speed = 0;
    power = power;
  }

  (* Updates the bot for a single logic tick *)
  let step t =
    A.step t
end
