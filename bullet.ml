(* type of a bullet *)
type t = {
  xPos : float;
  yPos : float;
  xDir : float;
  yDir : float;
  speed : float;
  id : int;
  power : float;
}

(* gets the position of the bullet *)
let getPosition bullet = 
	(bullet.xPos, bullet.yPos)

(* gets direction of the bullet *)
let getDirection bullet = 
	(bullet.xDir, bullet.yDir)

(* gets speed of the bullet *)
let getSpeed bullet = 
	bullet.speed

(* gets the id of the bot that shot the bullet *)
let getID bullet = 
	bullet.id

(* gets power of the bullet *)
let getPower bullet = 
	bullet.power

(* creates a bullet *)
let make (x, y) (xd, yd) sp p i = {
  xPos = x;
  yPos = y;
  xDir = xd;
  yDir = yd;
  speed = sp;
  id = i;
  power = p
}

(* steps the bullet *)
let step bullet = {
	xPos = bullet.xPos +. bullet.xDir *. bullet.speed;
	yPos = bullet.yPos +. bullet.yDir *. bullet.speed;
	xDir = bullet.xDir;
	yDir = bullet.yDir;
	speed = bullet.speed;
	id = bullet.id;
	power = bullet.power
}
