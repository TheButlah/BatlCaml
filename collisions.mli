open Bullet
open Bot

(* returns true if a bullet is colliding with a bot that didn't shoot 
 * that bullet *)
val bulletCollision : Bullet.t -> Bot.t -> bool

(* returns true if two bots are colliding and they are not the same bot *)
val botCollision : Bot.t -> Bot.t -> bool

(* returns a bot in the correct position if the bot is outside the game *)
val adjustBot : float -> float -> Bot.t -> Bot.t

(* true if bullet is outside the boundaries *)
val bulletOutside : float -> float -> Bullet.t -> bool
