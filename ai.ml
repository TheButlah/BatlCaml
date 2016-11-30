open Api

let step you =
	if (let (x, y) = getPos you in x > 0. )
	then shoot ()
	else turnLeft 90. 

let step2 you = 
	turnRight 90.