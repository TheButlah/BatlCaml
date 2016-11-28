module BotHandler = struct
  
  (* constants for math *)
  let pi = 3.14159265358979312

  let toRad (deg : float) = 
    ((mod_float deg 360.)/.360.) *. 2. *. pi

  let toDeg (rad : float) = 
    ((mod_float rad (2. *. pi))/.(2. *. pi)) *. 360.

  (* type of command returned by ai step function *)
  type command = 
    | NoCmd
    | Shoot 
    | Forward of float
    | LT of float
    | RT of float

  (* The type representing a bot (like a pointer to a bot object) *)
  type handle = int

  (* The type of a bot *)
  type t = {
    mutable xPos : float;
    mutable yPos : float;
    mutable xDir : float;
    mutable yDir : float;
    mutable power : float;
    mutable others : data list; (* each bot has info about every other bot *)
    speed : float;
  }
  and 
  (* Single element in [bots] *)
  data = {handle : handle; mutable bot : t; mutable step : handle -> command}

  (* data structure holding all the bots and the associated step function *)
  type bots = data list ref 

  (* The type of a bullet *)
  type bullet = {
    mutable xPos : float;
    mutable yPos : float;
    mutable xVel : float;
    mutable yVel : float;
    owner : handle;
  }

  (* Data structure holding all the bullets *)
  type bullets = bullet list ref 

  (* static datastructure holding all bots and their step functions and handles *)
  let bots = ref []

  (* static datastructure holding all bullets their and handles *)
  let bullets = ref []

  (* room size *)
  let roomSize = ref (0, 0)

  (* sets the room size *)
  let setRoomSize x y = 
    roomSize := (x, y)

  (* creates a new handle *)
  let newvar = ref 0
  let newHandle () = 
    let handle = !newvar in 
    let _ = newvar := !newvar+1 in
    handle

  (* helper that searches through [bots] and returns record 
   * takes in a handle and data list and outputs data *)
  let rec searchHandles (handle : handle) (bots : data list) : data = 
    match bots with 
    | [] -> failwith "unknown handle"
    | h::t -> if h.handle = handle then h else searchHandles handle t

  (* Gets the Position of the bot 
   * returns A 2D Tuple of the position in x,y *)
  let getPosition handle =
    let data = (searchHandles handle !bots).bot in 
    (data.xPos, data.yPos)

  (* Gets the Direction of the bot
   * returns A 2D Tuple of the direction in x,y *)
  let getDirection handle = 
  let data = (searchHandles handle !bots).bot in 
    (data.xDir, data.yDir)

  (* Gets the Speed of the bot *)
  let getSpeed handle =
    (searchHandles handle !bots).bot.speed

  (* Get the power level of the bot *)
  let getPower handle =
    (searchHandles handle !bots).bot.power

  (* Sets the Position of the bot *)
  let setPosition handle (x, y) = 
    let _ = (searchHandles handle !bots).bot.xPos <- x in 
    (searchHandles handle !bots).bot.yPos <- y

  (* Sets the Direction of the bot*)
  let setDirection handle (x, y) = 
    let _ = (searchHandles handle !bots).bot.xDir <- x in 
    (searchHandles handle !bots).bot.yDir <- y

  (* Moves the bot forward *)
  let moveForward handle amt = 
    let bot = (searchHandles handle !bots).bot in
    bot.xPos <- (bot.xDir *. amt *. bot.speed) +. bot.xPos;
    bot.yPos <- (bot.yDir *. amt *. bot.speed) +. bot.yPos

  (* Set the power level of the bot *)
  let setPower handle pwr = 
    (searchHandles handle !bots).bot.power <- pwr

  (* Create a bullet with a given handle *)
  let shoot handle = 
    let shootingbot = (searchHandles handle !bots).bot in 
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
      let (x2,y2) = (sin theta', cos theta') in
      setDirection handle (x2,y2)
    | RT deg ->
      let deg' = 360. -. (mod_float deg 360.) in
      let (x1,y1) = getDirection handle in
      let theta' = mod_float ((atan2 y1 x1) +. toRad deg') (2. *. pi) in
      let (x2,y2) = (sin theta', cos theta') in
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

end
