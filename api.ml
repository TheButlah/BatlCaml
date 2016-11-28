open Bot

(* type of datastructure maintained by the api *)
type handle = Bot.handle

(* command type variant *)
type command = Bot.command

(* rotates the bot left *)
let turnLeft deg = 
	Bot.makeCommand "LT" deg

(* rotates the bot right *)
let turnRight deg = 
	Bot.makeCommand "RT" deg

(* shoots a bullet *)
let shoot () =
	Bot.makeCommand "Shoot" 0.0

(* moves forward *)
let forward amt = 
	Bot.makeCommand "Forward" amt

(* does nothing *)
let noCommand () = 
	Bot.makeCommand "NoCmd" 0.0

(* returns health of self *)
let getHealth handle = 
	Bot.getPower handle

(* returns position of self *)
let getPos handle = 
	Bot.getPosition handle

(* returns direction of self *)
let getDirection handle = 
	Bot.getDirection handle

(* returns speed of self *)
let getSpeed handle = 
	Bot.getSpeed handle

(* get the (length,width) of room *)
let getRoomSize () = 
	!Bot.roomSize
