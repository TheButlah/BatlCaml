module type BotHandler = sig
  
  (* type of command returned by ai step function *)
  type command

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

  (* speed constant *)
  val speed : float

  (* static datastructure holding all bots and their step functions and handles *)
  val bots : bots

  (* static datastructure holding all bullets and their handles *)
  val bullets : bullets

  (* creates a new handle *)
  val newHandle : int

  (* room size *)
  val roomSize : (int * int) ref

  (* sets the room size *)
  val setRoomSize : int -> int -> unit

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

  (* Moves the bot forward by a constant amount*)
  val moveForward : handle -> unit

  (* Set the power level of the bot *)
  val setPower : handle -> float -> unit

  (* Create a bullet with a given handle *)
  val shoot : handle -> unit

  (* assigns a step function to the bot with handle [handle] *)
  val assignStep : handle -> (handle -> unit) -> unit

  (* Makes a new bot with a given position, direction, and power level, adds 
   * bot to list of bots and returns a handle
   * [make (xPos,yPos) (xVec,yVec) power] *)
  val make : (float * float) -> (float * float) -> float -> (t -> t) -> handle

  (* Updates all bots for a single logic tick *)
  val step : unit -> unit

  (* Updates all bullets for a single logic tick *)
  val stepBullet : unit -> unit

  (* Executes the returned variant of the step function for Ai *)
  val execute : handle -> unit

  (* Constructs a command variant using string [string] *)
  val makeCommand : string -> command
end
