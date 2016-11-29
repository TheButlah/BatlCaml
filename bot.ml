(* type of command returned by ai step function *)
type command = 
  | LT of float
  | RT of float
  | Shoot
  | Forward of float
  | Wait

(* math helpers *)
let pi = 3.14159265359

let toRad (deg : float) = 
  ((mod_float deg 360.)/.360.) *. 2. *. pi

let toDeg (rad : float) = 
  ((mod_float rad (2. *. pi))/.(2. *. pi)) *. 360.

(* The type of a bot *)
type t = {
  xPos : float;
  yPos : float;
  xDir : float;
  yDir : float;
  power : float;
  stepFunc : (t -> command); 
  maxSpeed : float;
}

(* Gets the Position of the bot 
 * returns A 2D Tuple of the position in x,y *)
let getPosition bot =
  (bot.xPos, bot.yPos)

(* Gets the Direction of the bot
 * returns A 2D Tuple of the direction in x,y *)
let getDirection bot = 
  (bot.xDir, bot.yDir)

(* Gets the maximum speed of the bot *)
let getMaxSpeed bot =
  bot.maxSpeed

(* Get the power level of the bot *)
let getPower bot =
  bot.power

(* Sets the Position of the bot *)
let setPosition (x, y) bot = 
  {bot with xPos = x;
            yPos = y;}

(* Sets the Direction of the bot*)
let setDirection (x, y) bot = 
  {bot with xDir = x;
            yDir = y;}

(* Moves the bot forward *)
let moveForward speedPct bot =
  {bot with xPos = (bot.xDir *. speedPct *. bot.maxSpeed) +. bot.xPos;
            yPos = (bot.yDir *. speedPct *. bot.maxSpeed) +. bot.yPos;}

(* Set the power level of the bot *)
let setPower pwr bot = 
  {bot with power = pwr} 

(* Makes a new bot with a given position, direction, power level, and max speed.
 * Also assigns the ai step function to the bot.
 * [make (xPos,yPos) (xVec,yVec) power maxSpeed stepAI] *)
let make (xPos,yPos) (xVec,yVec) power maxSpeed stepAI = {
    xPos = xPos;
    yPos = yPos;
    xDir = xVec;
    yDir = yVec;
    maxSpeed = maxSpeed;
    power = power;
    stepFunc = stepAI;} 
