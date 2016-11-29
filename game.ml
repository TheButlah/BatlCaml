open Ai
open Bot

let roomwidth = 500;;
let roomheight = 500;;
let roomspeed = 10.0;;

let handle1 = Bot.make (0.0, 0.0) (0.0, 0.0) 100.0 roomspeed;;
let handle2 = Bot.make (5.0, 5.0) (0.0, 0.0) 100.0 roomspeed;;

Bot.assignStep handle1 (Ai.step1 handle2);;
Bot.assignStep handle2 (Ai.step2 handle1);;

Bot.setRoomSize roomwidth roomheight

let step () =
  Bot.step ();
  Bot.stepBullets ()

let getBullets () = 
  Bot.bullets

let getBots () =
  Bot.bots

let getWidth () =
  roomwidth

let getHeight () =
  roomheight
