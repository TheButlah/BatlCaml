open Apiexternal

let turned = ref false
let shot = ref false

(* RANDO THE MAGNIFICENT *)
let step you = 
	let rand = Random.int 4 in
	if rand = 0 then
		let enemies = getEnemies you in
		if List.length enemies > 0 then
			let e = List.hd enemies in
			let (x2,y2) = (e.xPos,e.yPos) in
			let (x1,y1) = getPos you in
			let (x',y') = ((x2-.x1),(y2-.y1)) in
			let (x,y) = getDirection you in
			let dot = (x*.x')+.(y*.y') in
			let mag1 = sqrt (x**2. +. y**2.) in 
			let mag2 = sqrt (x'**2. +. y'**2.) in 
			let operand = dot/.(mag1*.mag2) in
			if operand >1. || operand < -1. then
				turnLeft 45.
			else
				let pi = 3.14159265359 in
				let theta = ((mod_float (acos operand) (2. *. pi))/.(2. *. pi)) *. 360. in
				turnLeft theta
		else turnRight 45.
(* 	else if rand = 1 then
		turnLeft 45. *)  
	else if rand = 2 then
		shoot()
	else
		forward 0.5

let _ = register step
