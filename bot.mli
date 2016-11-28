module type BotHandler = sig
  (* The type of a bullet *)
  type bullet

  (* Data structure holding all the bullets *)
  type bullets

  (* The type of a bot *)
  type t

  (* The type representing a bot (like a pointer to a bot object) *)
  type handle

  (* data structure holding all the bots and the associated step function *)
  type bots

  (* static datastructure holding all bots and their step functions and handles *)
  val bots : bots

  (* static datastructure holding all bullets and their handles *)
  val bullets : bullets

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

  (* Sets the Position of the bot *)
  val setPosition : handle -> float * float -> unit

  (* Sets the Direction of the bot*)
  val setDirection : handle -> float * float -> unit

  (* Sets the Speed of the bot *)
  val setSpeed : handle -> float -> unit

  (* Set the power level of the bot *)
  val setPower : handle -> float -> unit

  (* Makes a new bot with a given position, direction, and power level, adds 
   * bot to list of bots and returns a handle
   * [make (xPos,yPos) (xVec,yVec) power] *)
  val make : (float * float) -> (float * float) -> float -> (t -> t) -> handle

  (* Updates all bots for a single logic tick *)
  val step : unit -> unit

  (* Updates all bullets for a single logic tick *)
  val stepBullet : unit -> unit
end
