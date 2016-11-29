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

(* Value of PI *)
let pi = 3.14159265359

let init (aiList :(Bot.t -> Bot.command) list) seed botRadius =
	Random.init seed; 
	let roomWidth = 500.0 in
	let roomHeight = 500.0 in
	let maxBotSpeed = 10.0 in
	let bulletSpeed = 50.0 in
	let startingPower = 100.0 in

	let randAngle = Random.float (2.0 *. pi) in
	let botList = List.map (fun ai -> 
	    Bot.make (Random.float (roomWidth -. 2.0*.botRadius) +. botRadius,
	              Random.float (roomHeight -. 2.0*.botRadius) +. botRadius)
	             (cos randAngle, sin randAngle)
	             startingPower maxBotSpeed ai) aiList in
	state.roomWidth <- roomWidth;
	state.roomHeight <- roomHeight;
	state.maxBotSpeed <- maxBotSpeed;
	state.bulletSpeed <-bulletSpeed;
	state.botList <- botList;
	state.bulletList <- []

let step () =
	state.botList <- List.map (fun x -> x.stepFunc x |> execute x) state.botList;
	state.bulletList <- List.map (fun x -> Bullet.step x) state.bulletList
 
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
	| RT deg -> 
	| Shoot -> 
	| Forward amt -> 
	| Wait -> 





