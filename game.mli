module Bullet : Bullet
module Bot : Bot

val step : t -> t

val getBullets : t -> Bullet.t list

val getBots : t -> Bot.t list

val getWidth : t -> int
val getHeight : t -> int

val getScore : t -> int
