open Ai
open Bot
open Bullet

type t

module TheAI : Bot.AI = struct 
  type t = int
  let step t = failwith "Unimpelemnted"
end

module Bot = MakeBot (TheAI)
module Bullet = MakeBullet (Bot)

let step t =
  failwith "Unimplemented"

let getBullets t = 
  failwith "Unimplemented"

let getBots t =
  failwith "Unimplemented"

let getWidth t =
  failwith "Unimplemented"

let getHeight t =
  failwith "Unimplemented"

let getScore t =
  failwith "Unimplemented"
