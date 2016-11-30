open Bot
open Bullet

type t = {
	mutable roomWidth : float;
	mutable roomHeight : float;
	mutable maxBotSpeed : float;
	mutable bulletSpeed : float;
	mutable botList : Bot.t list;
	mutable bulletList : Bullet.t list
}

let state = {
	roomWidth = -1.0;
	roomHeight = -1.0;
	maxBotSpeed = -1.0;
	bulletSpeed = -1.0;
	botList = [];
	bulletList = []
}

let bulletpower = 10.

(* Math helpers *)
let pi = 3.14159265359

let toRad (deg : float) =
  ((mod_float deg 360.)/.360.) *. 2. *. pi

let toDeg (rad : float) =
  ((mod_float rad (2. *. pi))/.(2. *. pi)) *. 360.

let init (aiList :(Bot.t -> Bot.command) list) seed =
	Random.init seed; 
	let roomWidth = 500.0 in
	let roomHeight = 500.0 in
	let maxBotSpeed = 10.0 in
	let bulletSpeed = 50.0 in
	let startingPower = 100.0 in
	let botRadius = 5.0 in 

	let randAngle = Random.float (2.0 *. pi) in
	let botList = List.map (fun ai ->
	    Bot.make (Random.float (roomWidth -. 2.0*.botRadius) +. botRadius,
	              Random.float (roomHeight -. 2.0*.botRadius) +. botRadius)
	             (cos randAngle, sin randAngle)
	             startingPower maxBotSpeed botRadius ai) aiList in
	state.roomWidth <- roomWidth;
	state.roomHeight <- roomHeight;
	state.maxBotSpeed <- maxBotSpeed;
	state.bulletSpeed <-bulletSpeed;
	state.botList <- botList;
	state.bulletList <- []

let getBullets () =
	state.bulletList

let getBots () =
	state.botList

let getWidth () =
	state.roomWidth

let getHeight () =
	state.roomHeight

let execute bot cmd =
 	match cmd with
	| LT deg ->
		let (x1,y1) = Bot.getDirection bot in
	    let theta' = mod_float ((atan2 y1 x1) +. toRad deg) (2. *. pi) in
	    let (x2,y2) = (cos theta', sin theta') in
	    Bot.setDirection (x2,y2) bot
	| RT deg ->
		let deg' = 360. -. (mod_float deg 360.) in
	    let (x1,y1) = Bot.getDirection bot in
	    let theta' = mod_float ((atan2 y1 x1) +. toRad deg') (2. *. pi) in
	    let (x2,y2) = (cos theta',sin theta') in
	    Bot.setDirection (x2,y2) bot
	| Shoot ->
		let pos = Bot.getPosition bot in
		let dir = Bot.getDirection bot in
		let id = Bot.getID bot in
		let spd = state.bulletSpeed in
		state.bulletList <- state.bulletList@[Bullet.make pos dir spd bulletpower id];
		bot
	| Forward amt ->
		Bot.moveForward amt bot
	| Wait ->
		bot

let handleCollisions () =
  let rec enemy bot acc = 
    match bot with
    | [] -> acc
    | h1::t1 ->
      let bottemp = ref h1 in
      let rec bulletList bullets acc2 = (
        match bullets with
        | [] -> acc2
        | h2::t2 ->
          let bulletcol = Collisions.bulletCollision h2 h1 in 
          if bulletcol then
              let _ = bottemp := Bot.setPower (Bot.getPower !bottemp -. Bullet.getPower h2) !bottemp in
              bulletList t2 acc2@[h2]
          else bulletList t2 acc2
      )
      in state.bulletList <- bulletList state.bulletList [];
      if Bot.getPower !bottemp <= 0.0
      then enemy t1 acc
      else enemy t1 (acc@[!bottemp])
  in state.botList <- enemy state.botList []

let adjustBotPositions () =
	let rec adjust bots acc = 
		match bots with
		| [] -> acc
		| h::t -> 
			let bot' = Collisions.adjustBot state.roomWidth state.roomHeight h in
			adjust t (acc@[bot'])
	in state.botList <- adjust state.botList []

let adjustBullets () =
	let w = state.roomWidth in 
	let h = state.roomHeight in 
	let outside = Collisions.bulletOutside in 
	state.bulletList <- List.filter (outside w h) state.bulletList

let step () =
	let stepbot x = x |> Bot.getStepFunc x |> execute x in
	state.botList <- List.map stepbot state.botList;
	state.bulletList <- List.map (fun x -> Bullet.step x) state.bulletList;
	adjustBotPositions ();
	adjustBullets ();
	handleCollisions ()

let finished () = 
	List.length state.botList = 1





