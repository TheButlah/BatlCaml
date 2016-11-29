open Bot

let roomSize = (500,500)

(* rotates the bot left *)
let turnLeft deg = 
  LT deg

(* rotates the bot right *)
let turnRight deg = 
  RT deg

(* shoots a bullet *)
let shoot () =
  Shoot

(* moves forward *)
let forward amt = 
  Forward amt

(* does nothing *)
let wait () = 
  Wait

(* returns health of self *)
let getHealth bot = 
	Bot.getPower bot

(* returns position of self *)
let getPos bot = 
	Bot.getPosition bot

(* returns direction of self *)
let getDirection bot = 
	Bot.getDirection bot

(* returns speed of self *)
let getSpeed bot= 
	Bot.getMaxSpeed bot

(* get the (length,width) of room *)
let getRoomSize () = 
	roomSize
