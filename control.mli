open Game

val loop : int -> Game.t -> Game.t

val getState : Game.t -> string

val setPause : bool -> unit

val isPaused : unit -> bool
