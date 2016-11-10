module type Bullet = sig
  (* The type of a bullet that has a position, velocity, and owner *)
  type t

  (* The type of the owner of the bullet, i.e. the bot that shot it *)
  type bot

  (* Gets the Position of the bullet 
   * returns A 2D Tuple of the position in x,y *)
  val getPosition : t -> float * float

  (* Gets the Velocity of the bullet
   * returns A 2D Tuple of the velocity in x,y *)
  val getVelocity : t -> float * float

  (* Gets the Speed of the bullet *)
  val getSpeed : t -> float

  (* Gets the bot that shot the bullet *)
  val getOwner : t -> bot

  (* Makes a new bullet with a given position, velocity, and owner
   * [make (xPos,yPos) (xVel,yVel) owner] *)
  val make : (float * float) -> (float * float) -> bot -> t

  (* Updates the bullet for a single logic tick *)
  val step : t -> t
end

module type Bot = sig
  (* The type of Bot *)
  type t
end

module type MakeBullet =
  functor (B : Bot) -> Bullet with type bot = B.t

module MakeBullet (B : Bot) = struct
  type bot = B.t

  type t = {
    xPos : float;
    yPos : float;
    xVel : float;
    yVel : float;
    speed : float;
    owner : B.t;
  }

  let getPosition t =
    failwith "Unimplemented"

  let getVelocity t =
    failwith "Unimplemented"

  let getSpeed t =
    failwith "Unimplemented"

  let getOwner t =
    failwith "Unimplemented"

  let make (xPos,yPos) (xVel,yVel) bot =
    failwith "Unimplemented"

  let step t =
    failwith "Unimplemented"

end
