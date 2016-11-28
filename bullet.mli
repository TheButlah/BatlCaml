module type BulletHandler = sig
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

(* Makes a bullet associated with a particular bot *)
module type MakeBullet = 
  functor (B : Bot) -> Bullet with type bot = B.t

module MakeBullet : MakeBullet
