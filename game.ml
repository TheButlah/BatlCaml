open Bot
(* open Bullet *)

type t = {
  roomWidth : float;
  roomHeight : float;
  maxBotSpeed : float;
  bulletSpeed : float;
  botList : Bot.t list;
  (* bulletList : Bullet.t list *)
}

(* Value of PI *)
let pi = 3.14159265359

let make (aiList :(Bot.t -> Bot.command) list) seed botRadius=
  Random.init seed; 
  let roomWidth = 500.0 in
  let roomHeight = 500.0 in
  let maxBotSpeed = 10.0 in
  let bulletSpeed = 50.0 in
  let startingPower = 100.0 in

  let randAngle = Random.float (2.0 *. pi) in
  let botList = List.map (fun ai -> 
    Bot.make (Random.float (roomWidth -. 2.0*.botRadius) +. botRadius,
              Random.float (roomHeight -. 2.0*.botRadius) +. botRadius)
             (cos randAngle, sin randAngle)
             startingPower maxBotSpeed ai) aiList in
  {
    roomWidth = roomWidth;
    roomHeight = roomHeight;
    maxBotSpeed = maxBotSpeed;
    bulletSpeed = bulletSpeed;
    botList = botList;
    (* bulletList = []; *)
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
