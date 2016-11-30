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
	diff && distbetween < dist

(* returns a bot in the correct position if the bot is outside the game *)
let adjustBot w h bot =
	let (x, y) = Bot.getPosition bot in 
	let x' = if x < 0. then 0. else if x > w then w else x in 
	let y' = if y < 0. then 0. else if y > h then h else y in 
	Bot.setPosition (x', y') bot

(* true if bullet is outside the boundaries *)
let bulletOutside w h bullet = 
	let (x, y) = Bullet.getPosition bullet in 
	x < 0. || x > w || y < 0. || y > h

