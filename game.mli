open Bot

(* steps the game one frame *)
val step : unit -> unit

(* returns the list of bullets currently in the game *)
val getBullets : unit -> Bot.bullets

(* returns the list of bots currently in the game *)
val getBots : unit -> BotHandler.bots

(* returns width of the room *)
val getWidth : unit -> int

(* returns height of the room *)
val getHeight : unit -> int

(* returns score of the game *)
val getScore : unit -> int
