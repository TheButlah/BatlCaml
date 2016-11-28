open Ai
open Bot

let handle1 = BotHandler.make (0.0, 0.0) (0.0, 0.0) 100.0
let handle2 = BotHandler.make (5.0, 5.0) (0.0, 0.0) 100.0

BotHandler.assignStep handle1 (Ai.step1 handle2)
BotHandler.assignStep handle2 (Ai.step2 handle1)

let step () =
  BotHandler.step ();
  BotHandler.stepBullets ()

let getBullets () = 
  BotHandler.bullets

let getBots () =
  BotHandler.bots

let getWidth () =
  failwith "Unimplemented"

let getHeight () =
  failwith "Unimplemented"

let getScore () =
  failwith "Unimplemented"
