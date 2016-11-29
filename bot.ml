(* type of command returned by ai step function *)
type command = 
  | NoCmd
  | Shoot 
  | Forward of float
  | LT of float
  | RT of float


(* math helpers *)
let pi = 3.14159265358979312

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

(* room size *)
let roomSize = ref (0, 0)

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
let setPosition bot (x, y) = 
  {bot with xPos = x;
            yPos = y;}

(* Sets the Direction of the bot*)
let setDirection bot (x, y) = 
  {bot with xDir = x;
            yDir = y;}

(* Moves the bot forward *)
let moveForward bot speedPct =
  {bot with xPos = (bot.xDir *. speedPct *. bot.maxSpeed) +. bot.xPos;
            yPos = (bot.yDir *. speedPct *. bot.maxSpeed) +. bot.yPos;}

(* Set the power level of the bot *)
let setPower bot pwr = 
  {bot with power = pwr} 

(* Create a bullet with a given handle *)
let shoot bot = 
  let newbullet = {
    xPos = shootingbot.xPos;
    yPos = shootingbot.yPos;
    xVel = shootingbot.xDir *. shootingbot.speed *. 0.5; (* calculate so that bullet speed is constant i.e. get unit vector from bot and multiply by constant*)
    yVel = shootingbot.yDir *. shootingbot.speed *. 0.5; (* calculate so that bullet speed is constant i.e. get unit vector from bot and multiply by constant*)
    owner = handle;
  } in
  bullets := (!bullets@[newbullet])

(* updates all [bot.others] with the current data list *)
let rec updateOthers (datalist : data list) = 
  match datalist with 
  | [] -> ()
  | h::t -> h.bot.others <- !bots; updateOthers t

(* Makes a new bot with a given position, direction, power level and step function
 * [make (xPos,yPos) (xVec,yVec) power] *)
let make (xPos,yPos) (xVec,yVec) power speed = 
  let bot = {
    xPos = xPos;
    yPos = yPos;
    xDir = xVec;
    yDir = yVec;
    speed = speed;
    power = power;
    others = !bots;
  } in
  let handle = newHandle () in 
  (* add bot to [bots] *)
  let _ = bots := {handle = handle; bot = bot; step = fun x -> NoCmd}::(!bots) in 
  (* update all bots' [others] list *)
  let _ = updateOthers !bots in
  handle

(* assigns a step function to the bot with handle [handle] *)
let assignStep (handle : handle) (step : handle -> command) : unit = 
  let bot = searchHandles handle !bots in 
  bot.step <- step

(* Updates all bullets for a single logic tick *)
let stepBullets () =
  let stepsingle (b : bullet) : unit =
    b.xPos <- b.xPos +. b.yVel;
    b.yPos <- b.yPos +. b.yVel
  in let rec stepall (current : bullet list) (acc : bullet list) : bullet list= (
    match current with 
    | [] -> acc 
    | h::t -> stepall t (stepsingle h; (acc@[h]))
  ) in
  bullets := stepall !bullets [] 

(* Executes the returned variant of the step function for Ai *)
let execute handle = function
  | NoCmd -> ()
  | Shoot -> shoot handle
  | Forward a -> moveForward handle a
  | LT deg -> 
    let (x1,y1) = getDirection handle in
    let theta' = mod_float ((atan2 y1 x1) +. toRad deg) (2. *. pi) in
    let (x2,y2) = (cos theta', sin theta') in
    setDirection handle (x2,y2)
  | RT deg ->
    let deg' = 360. -. (mod_float deg 360.) in
    let (x1,y1) = getDirection handle in
    let theta' = mod_float ((atan2 y1 x1) +. toRad deg') (2. *. pi) in
    let (x2,y2) = (cos theta', sin theta') in
    setDirection handle (x2,y2)

(* Constructs a command variant using string [string] *)
let makeCommand s arg = 
  match s with 
  | x when x = "Shoot" -> Shoot
  | x when x = "Forward" -> Forward arg
  | x when x = "LT" -> LT arg
  | x when x = "RT" -> RT arg
  | _ -> NoCmd

(* Updates all bots for a single logic tick *)
let step () =
  let rec stepall (current : data list) (acc : data list) = (
    match current with
    | [] -> acc
    | h::t -> 
      let _ = h.step h.handle |> execute h.handle in
      stepall t (h::acc)
  ) in 
  let _ = bots := (stepall !bots []) in
  updateOthers !bots
