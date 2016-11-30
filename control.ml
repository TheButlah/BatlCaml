open Game
open Bot 
open Bullet

type bulletInfo = {
	x : float;
	y : float
}

type botInfo = {
	x : float;
	y : float;
	dir : float * float
}

type t = {
	bulletList : bulletInfo list;
	botList : botInfo list;
	finished : bool;
	width : float;
	height : float
}

let init () = 
	failwith "Unimplemented" 

let step () =
	(* let _ = Game.step () in 
	let height = Game.getHeight () in 
	let width = Game.getWidth () in  *)
	failwith "Unimplemented"

	
