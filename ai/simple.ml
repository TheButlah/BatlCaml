open Api

let turnTo (x,y) (x',y') =
	let dot = (x*.x')+.(y*.y') in
	let mag1 = sqrt (x**2. +. y**2.) in 
	let mag2 = sqrt (x'**2. +. y'**2.) in 
	let operand = dot/.(mag1*.mag2) in
	if operand >1. || operand < -1. then
		5.
	else
		let pi = 3.14159265359 in
		let theta = ((mod_float (acos operand) (2. *. pi))/.(2. *. pi)) *. 360. in
		theta

let turned = ref false

(* circles around the edges of the game *)
let step you = 
	let (xd,yd) = getDirection you in
	let (x,y) = getPos you in
	let (a,b) = getRoomSize() in
	if getEnergy you < 15. then
		wait()
	else if (x = 0. || x = a) && (y = 0. || y = a) && not !turned then
		let _ = turned := true in
		turnRight 90.
	else if x = 0. && y <> 0. then
		if (xd <> 0.) && (yd <> (-1.)) then
			turnLeft (turnTo (xd,yd) (0.,-1.))
		else 
			let _ = turned := false in
			forward 1.
	else if y = b then
		if (xd <> (-1.)) && (yd <> 0.) then
			turnLeft (turnTo (xd,yd) (-1.,0.))
		else 
			let _ = turned := false in
			forward 1.	
	else if x = a then
		if xd <> 0. && yd <> 1. then
			turnLeft (turnTo (xd,yd) (0.,1.))
		else
			let _ = turned := false in
			forward 1.
	else if y = 0. then
		if xd <> 1. && yd <> 0. then
			turnLeft (turnTo (xd,yd) (1.,0.))
		else 
			let _ = turned := false in
			forward 1.
	else forward 1.

let _ = register step