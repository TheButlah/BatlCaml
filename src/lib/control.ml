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
  height : float;
  maxPower : float
}

let aiList = ref []

let numAI = ref 0

let finishedLoadingAI = ref false

let prevRand = ref (Random.self_init (); Random.bits ())
let firstRand = !prevRand

exception MultipleAIRegisters
exception NotEnoughAI of int

(* initializes a game *)
let init seed = 
  try
    if !numAI <= 1 then raise (NotEnoughAI !numAI) else
    let resultRand = !prevRand in
    prevRand := firstRand;
    for i = 1 to !numAI do
      prevRand := (Random.init !prevRand; Random.bits ());
      (*print_endline ("in control loop on " ^ (string_of_int i) ^ ", rand is " ^ (string_of_int !prevRand))*)
    done;
    if resultRand <> !prevRand then raise MultipleAIRegisters else
    finishedLoadingAI := true;
	  let roomWidth = 500.0 in
	  let roomHeight = 500.0 in
	  let maxBotSpeed = 10.0 in
	  let bulletSpeed = 5.0 in
	  let startingPower = 100.0 in
    let maxPower = 100.0 in
	  let rad = 5.0 in 
	  let spwr = 10.0 in
	  Game.init !aiList seed roomWidth roomHeight maxBotSpeed maxPower bulletSpeed startingPower rad spwr
  with
  | NotEnoughAI numAI ->
    print_endline "The program could not detect enough AI.";
    print_endline "Please ensure that the AI directory has at least 2 AI in it.";
    print_endline ("Number of AI units detected: " ^ (string_of_int numAI));
    exit 1
  | MultipleAIRegisters -> 
    print_endline "An AI was registered more than once!";
    print_endline "Please ensure each AI file has exactly one call to register.";
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
  let power = Game.getMaxPower () in
	{
		bulletList = List.map makeBulletInfo bulletlist;
		botList = List.map makeBotInfo botlist;
		finished = Game.finished ();
		width = width;
    height = height;
    maxPower = power
	}

let registerAI aiFunc =
  if !finishedLoadingAI then () else
  let rand = (Random.init !prevRand; Random.bits ()) in
  (*print_endline ("In register AI, rand is " ^ (string_of_int rand));*)
  prevRand := rand;
  aiList:= aiFunc::(!aiList)
