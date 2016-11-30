open Bullet 
open Bot

let distance (x, y) (x2, y2) = 
	sqrt((x -. x2)**2. +. (y -. y2)**2.)

(* returns true if a bullet is colliding with a bot that didn't shoot 
 * that bullet *)
let bulletCollision bullet bot =
	let bulletid = Bullet.getID bullet in 
	let botid = Bot.getID bot in 
	let diff = bulletid <> botid in 
	let distbetween = distance (Bullet.getPosition bullet) (Bot.getPosition bot) in 
	diff && distbetween < (Bot.getRadius bot)

(* returns true if two bots are colliding and they are not the same bot *)
let botCollision bot1 bot2 =
  let dist = max (Bot.getRadius bot1) (Bot.getRadius bot2) in 
  let diff = (Bot.getID bot1) <> (Bot.getID bot2) in 
  let distbetween = distance (Bot.getPosition bot1) (Bot.getPosition bot2) in 
  diff && distancebetween < dist
