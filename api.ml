open Bot

(* type of datastructure maintained by the api *)
type handle = BotHandler.handle

(* command type variant *)
type command = BotHandler.command

(* rotates the bot left *)
let turnLeft deg = 
	BotHandler.makeCommand "LT" deg

(* rotates the bot right *)
let turnRight deg = 
	BotHandler.makeCommand "RT" deg

(* shoots a bullet *)
let shoot () =
	BotHandler.makeCommand "Shoot" 0.0

(* moves forward *)
let forward amt = 
	BotHandler.makeCommand "Forward" amt

(* does nothing *)
let noCommand () = 
	BotHandler.makeCommand "NoCmd" 0.0

(* returns health of self *)
let getHealth handle = 
	BotHandler.getHealth handle

(* returns position of self *)
let getPos handle = 
	BotHandler.getPosition

(* returns direction of self *)
let getDirection handle = 
	BotHandler.getDirection handle

(* returns speed of self *)
let getSpeed handle = 
	BotHandler.getSpeed handle

(* get the (length,width) of room *)
let getRoomSize () = 
	BotHandler.roomSize
