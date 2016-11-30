open Game
open Bot 
open Bullet
open Ai

(* info for bullets *)
type bulletInfo = {
	x : float;
	y : float;
	dir : float * float;
	owner : int
}

(* info for bots *)
type botInfo = {
	x : float;
	y : float;
	dir : float * float;
	power : float;
	id : int
}

(* type returned by the step function *)
type t = {
	bulletList : bulletInfo list;
	botList : botInfo list;
	finished : bool;
	width : float;
	height : float
}

(* initializes a game *)
let init () = 
	let roomWidth = 500.0 in
	let roomHeight = 300.0 in
	let maxBotSpeed = 10.0 in
	let bulletSpeed = 2.0 in
	let startingPower = 100.0 in
	let rad = 5.0 in 
	let spwr = 10.0 in
	let seed = 10 in 
	Game.init [Ai.step; Ai.step2] seed roomWidth roomHeight maxBotSpeed bulletSpeed startingPower rad spwr 

(* creates a botinfo record from a bot *)
let makeBotInfo bot = 
	let (bx, by) = Bot.getPosition bot in 
	{
		x = bx;
		y = by;
		dir = Bot.getDirection bot;
		power = Bot.getPower bot;
		id = Bot.getID bot
	}

(* creates a bulletinfo record from a bullet *)
let makeBulletInfo bullet = 
	let (bx, by) = Bullet.getPosition bullet in 
	{
		x = bx;
		y = by;
		dir = Bullet.getDirection bullet;
		owner = Bullet.getID bullet
	}

(* steps the game and returns a datastructure that can be used for view *)
let step () =
	let _ = Game.step () in 
	let height = Game.getHeight () in 
	let width = Game.getWidth () in 
	let botlist = Game.getBots () in 
	let bulletlist = Game.getBullets () in 
	{
		bulletList = List.map makeBulletInfo bulletlist;
		botList = List.map makeBotInfo botlist;
		finished = Game.finished ();
		width = width;
		height = height
	}

	
