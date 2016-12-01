open Bot
open Game
open Control

type bot = Bot.t
type command = Bot.command

(* enemy type *)
type enemy = {
	xPos : float;
	yPos : float;
	xDir : float;
	yDir : float;
	speed : float;
	power : float;
	id : int;
}

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
let getSpeed bot = 
	Bot.getMaxSpeed bot

(* returns id of self *)
let getID bot = 
	Bot.getID bot

(* get the (length,width) of room *)
let getRoomSize () = 
	(Game.getWidth (), Game.getHeight ())

(* makes an enemy given a bot *)
let makeEnemy bot = 
	let (x, y) = Bot.getPosition bot in 
	let (xd, yd) = Bot.getDirection bot in {
		xPos = x;
		yPos = y;
		xDir = xd;
		yDir = yd;
		speed = Bot.getMaxSpeed bot;
		power = Bot.getPower bot;
		id = Bot.getID bot
	}

(* gets the enemies of the game and returns a list of them *)
let getEnemies bot = 
	let rec iter bots acc = 
		match bots with 
		| [] -> acc
		| h::t -> 
			let en = makeEnemy h in 
			if en.id = getID bot
			then iter t acc 
			else iter t (acc@[en])
	in iter (Game.getBots ()) []

(* registers the step function so it can be recognized by 
 * the game; must be called at the end of every ai file *)
let register step = 
	Control.registerAI step




