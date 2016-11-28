module type Bot = sig

  (* The type of a bot *)
  type t

  (* The type representing a bot (like a pointer to a bot object) *)
  type handle

  (* data structure holding all the bots and the associated step function *)
  type bots

  (* static datastructure holding all bots and their step functions and handles *)
  val bots : bots

  (* creates a new handle *)
  val newHandle : int

  (* Gets the Position of the bot 
   * returns A 2D Tuple of the position in x,y *)
  val getPosition : handle -> float * float

  (* Gets the Direction of the bot
   * returns A 2D Tuple of the direction in x,y *)
  val getDirection : handle -> float * float

  (* Gets the Speed of the bot *)
  val getSpeed : handle -> float

  (* Get the power level of the bot *)
  val getPower : handle -> float

  (* Makes a new bot with a given position, direction, and power level, and returns a handle
   * [make (xPos,yPos) (xVec,yVec) power] *)
  val make : (float * float) -> (float * float) -> float -> (t -> t) -> handle

  (* Updates the bot with handle [handle] for a single logic tick *)
  val step : handle -> unit
end

(* Makes a bot with the given AI *)
module type MakeBot =
  functor (A : AI) -> Bot

module MakeBot : MakeBot
