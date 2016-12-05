(* type of command returned by ai step function *)
type command = 
  | LT of float
  | RT of float
  | Shoot
  | Forward of float
  | Wait

(* math helpers *)
let pi = 3.14159265358979324

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
  id : int;
  radius : float;
  shootPower : float
}

(* id static variable *)
let newid = ref 0

(* makes a new id *)
let makeid () = 
  let i = !newid in 
  let _ = newid := !newid + 1 in i

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

(* Gets energy of the bot *)
let getEnergy bot = 
  bot.energy

(* Get the power level of the bot *)
let getPower bot =
  bot.power

(* Gets id of the bot *)
let getID bot = 
  bot.id

(* Gets the step function of the bot *)
let getStepFunc bot = 
  bot.stepFunc

(* Gets the radius of the bot *)
let getRadius bot = 
  bot.radius

(* Gets the shoot power of the bot *)
let getShootPower bot = 
  bot.shootPower

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
let make (xPos,yPos) (xVec,yVec) power energy maxSpeed rad str stepAI = {
    xPos = xPos;
    yPos = yPos;
    xDir = xVec;
    yDir = yVec;
    maxSpeed = maxSpeed;
    power = power;
    energy = energy;
    stepFunc = stepAI;
    id = makeid ();
    radius = rad;
    shootPower = str
} 
