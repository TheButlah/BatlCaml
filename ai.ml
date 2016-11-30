open Api

let turned = ref false
let step you =
	if !turned then shoot () else 
	let _ = turned := true in turnLeft 65.

let step2 you = 
	forward 0.5