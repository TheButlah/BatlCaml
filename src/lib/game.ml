open Bot
open Bullet

type t = {
	mutable roomWidth : float;
	mutable roomHeight : float;
	mutable maxBotSpeed : float;
	mutable maxBotPower : float;
	mutable maxBotEnergy : float;
	mutable energyRestoreRate : float;
	mutable bulletSpeed : float;
	mutable botList : Bot.t list;
	mutable bulletList : Bullet.t list;
	mutable energyCost : Bot.command -> float;
}

let state = {
	roomWidth = -1.0;
	roomHeight = -1.0;
	maxBotSpeed = -1.0;
	maxBotPower = -1.0;
	maxBotEnergy = -1.0;
	energyRestoreRate = 0.0;
	bulletSpeed = -1.0;
	botList = [];
	bulletList = [];
	energyCost = fun x -> 0.0
}

(* Math helpers *)
let pi = 4. *. atan 1.

(* -2pi to 2pi exclusive *)
let toRad (deg : float) =
  ((mod_float deg 360.)/.360.) *. 2. *. pi

(* -360 to 360 exclusive *)
let toDeg (rad : float) =
  ((mod_float rad (2. *. pi))/.(2. *. pi)) *. 360.

let init (aiList :(Bot.t -> Bot.command) list) seed rw rh mbs mbp mbe ec err bs sp br spwr =
	Random.init seed; 
	let roomWidth = rw in
	let roomHeight = rh in
	let maxBotSpeed = mbs in
	let maxBotPower = mbp in 
	let maxBotEnergy = mbe in 
	let energyCost = ec in 
	let energyRestoreRate = err in 
	let bulletSpeed = bs in
	let startingPower = sp in
	let botRadius = br in 
	let shootpwr = spwr in 

	let randAngle = Random.float (2.0 *. pi) in
	let botList = List.map (fun ai ->
	    Bot.make (Random.float (roomWidth -. 2.0*.botRadius) +. botRadius,
	              Random.float (roomHeight -. 2.0*.botRadius) +. botRadius)
	             (cos randAngle, sin randAngle)
	             startingPower maxBotEnergy maxBotSpeed botRadius shootpwr ai) aiList in
	state.roomWidth <- roomWidth;
	state.roomHeight <- roomHeight;
	state.maxBotSpeed <- maxBotSpeed;
	state.maxBotPower <- maxBotPower;
	state.maxBotEnergy <- maxBotEnergy;
	state.energyCost <- energyCost;
	state.energyRestoreRate <- energyRestoreRate;
	state.bulletSpeed <- bulletSpeed;
	state.botList <- botList;
	state.bulletList <- []

let getBullets () =
	state.bulletList

let getBulletSpeed () =
  state.bulletSpeed

let getBots () =
	state.botList

let getWidth () =
	state.roomWidth

let getHeight () =
	state.roomHeight

let getMaxPower () = 
	state.maxBotPower

let getMaxEnergy () = 
	state.maxBotEnergy

let adjustEnergy cmd bot = 
	Bot.setEnergy (Bot.getEnergy bot -. state.energyCost cmd) bot

let execute bot cmd =
 	match cmd with
	| LT deg ->
		let (x1,y1) = Bot.getDirection bot in
	    let theta' = mod_float ((atan2 y1 x1) +. toRad deg) (2. *. pi) in
	    let (x2,y2) = (cos theta', sin theta') in
	    let bot' = adjustEnergy cmd bot in 
	    if Bot.getEnergy bot' = 0. then bot else
	    Bot.setDirection (x2,y2) bot'
	| RT deg ->
	    let (x1, y1) = Bot.getDirection bot in
	    let theta' = mod_float ((atan2 y1 x1) -. toRad deg) (2. *. pi) in
	    let (x2,y2) = (cos theta',sin theta') in
	    let bot' = adjustEnergy cmd bot in 
	    if Bot.getEnergy bot' = 0. then bot else
	    Bot.setDirection (x2,y2) bot'
	| Shoot ->
		let pos = Bot.getPosition bot in
		let dir = Bot.getDirection bot in
		let id = Bot.getID bot in
		let spd = state.bulletSpeed in
		let str = Bot.getShootPower bot in 
		let bot' = adjustEnergy cmd bot in 
    	if Bot.getEnergy bot' = 0. then bot else
		let _ = state.bulletList <- Bullet.make pos dir spd str id :: state.bulletList
		in bot'
	| Forward amt ->
		let bot' = adjustEnergy cmd bot in 
    	if Bot.getEnergy bot' = 0. then bot else
		Bot.moveForward (if amt > 1.0 then 1.0 else if amt < 0.0 then 0.0 else amt) bot'
	| Wait ->
		bot |> adjustEnergy cmd

let handleCollisions () =
  let rec enemy bots acc = 
    match bots with
    | [] -> acc
    | h1::t1 -> (
		let bottemp = ref h1 in
		let rec iterbullets bullets acc2 = (
	        match bullets with
	        | [] -> acc2
	        | h2::t2 ->
				if Collisions.bulletCollision h2 h1 
				then
					let botpower = Bot.getPower !bottemp in 
					let bulletpower = Bullet.getPower h2 in
					let _ = bottemp := Bot.setPower (botpower -. bulletpower) !bottemp in 
					iterbullets t2 acc2
				else iterbullets t2 (acc2@[h2])
		) in 
		let _ = state.bulletList <- iterbullets state.bulletList [] in 
		if Bot.getPower !bottemp <= 0.
		then enemy t1 acc
		else enemy t1 (acc@[!bottemp])
	)
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
	state.bulletList <- List.filter (fun x -> not (outside w h x)) state.bulletList

let step () =
	let calcenergy x = 
		let e' = Bot.getEnergy x +. state.energyRestoreRate in 
		if e' > state.maxBotEnergy 
		then Bot.setEnergy state.maxBotEnergy x
		else Bot.setEnergy e' x
	in
	let _ = state.botList <- List.map calcenergy state.botList in
	let stepbot x = x |> Bot.getStepFunc x |> execute x in
	state.botList <- List.map stepbot state.botList;
	state.bulletList <- List.map Bullet.step state.bulletList;
	adjustBotPositions ();
	adjustBullets ();
	handleCollisions ()

let finished () = 
	List.length state.botList <= 1

