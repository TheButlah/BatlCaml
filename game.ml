open Ai
open Bot

type t = {
  roomWidth : int;
  roomHeight : int;
  roomSpeed : float;
  handles : handle list;
}

let make () = 
  let roomWidth = 500 in
  let roomHeight = 500 in
  let roomSpeed = 10.0 in

  let handle1 = Bot.make (0.0, 0.0) (0.0, 0.0) 100.0 roomSpeed in
  let handle2 = Bot.make (5.0, 5.0) (0.0, 0.0) 100.0 roomSpeed in

  Bot.assignStep handle1 (Ai.step1 handle2);;
  Bot.assignStep handle2 (Ai.step2 handle1);;

  Bot.setRoomSize roomWidth roomHeight
  {
    roomWidth = roomWidth;
    roomHeight = roomHeight;
    roomSpeed = roomSpeed;
    handles = [handle1; handle2] 
  }


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
