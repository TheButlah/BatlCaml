open Api

let turned = ref false
let shot = ref false

let step you =
	if !turned 
	then 
		if !shot
		then wait ()
		else
			let _ = shot := true in 
			shoot () 
	else 
		let _ = turned := true in turnLeft 65.

let step2 you = 
	forward 0.5


