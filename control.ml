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
  try
    Dynlink.prohibit ["Bullet";"Bot";"Collisions";"Test";"Game";"Control";"View";"Main"];
    Dynlink.loadfile_private "_build/ai.cmo";
    let resultRand = !prevRand in
    prevRand := firstRand;
    for i = 0 to 0 do
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
  | Dynlink.Error Dynlink.File_not_found str ->
    print_endline "An AI file could not be found! This likely implies that it did not compile.";
    print_string "The file in question was: "; print_endline str;
    exit 1
  | Dynlink.Error Dynlink.Unavailable_unit str ->
    print_endline "An AI file tried to access a module that was prohibited! Are you cheating?";
    print_string "The unit's name was: "; print_endline str;
    exit 1
  | _ -> 
    print_endline "Sorry, one or more of the AIs provided are incorrect!";
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
  let rand = (Random.init !prevRand; Random.bits ()) in
  prevRand := rand;
  aiList:= aiFunc::(!aiList)
