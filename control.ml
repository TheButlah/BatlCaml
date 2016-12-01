open Game
open Bot 
open Bullet

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

let aiList = ref []

let prevRand = ref (Random.self_init (); Random.bits ())
let firstRand = !prevRand

exception MultipleAIRegisters

(* initializes a game *)
let init seed = 
  print_int (List.length !aiList);
  try
    let resultRand = !prevRand in
    prevRand := firstRand;
    for i = 0 to 1 do
      prevRand := (Random.init !prevRand; Random.bits ())
    done;
    if resultRand <> !prevRand then raise MultipleAIRegisters else
	  let roomWidth = 500.0 in
	  let roomHeight = 500.0 in
	  let maxBotSpeed = 10.0 in
	  let bulletSpeed = 5.0 in
	  let startingPower = 100.0 in
	  let rad = 5.0 in 
	  let spwr = 10.0 in
	  Game.init !aiList seed roomWidth roomHeight maxBotSpeed bulletSpeed startingPower rad spwr
  with
  | MultipleAIRegisters -> 
    print_endline "An AI was registered more than once! Are you cheating?";
    exit 1

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

let registerAI aiFunc =
  print_endline "register contol";
  let rand = (Random.init !prevRand; Random.bits ()) in
  prevRand := rand;
  aiList:= aiFunc::(!aiList)
