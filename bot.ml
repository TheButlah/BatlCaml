module BotHandler = struct

  (* The type representing a bot (like a pointer to a bot object) *)
  type handle = int

  (* The type of a bot *)
  type t = {
    mutable xPos : float;
    mutable yPos : float;
    mutable xDir : float;
    mutable yDir : float;
    mutable speed : float;
    mutable power : float;
    mutable others : data list; (* each bot has info about every other bot *)
  }
  and 
  (* Single element in [bots] *)
  data = {handle : handle; mutable bot : t; step : t -> t}

  (* data structure holding all the bots and the associated step function *)
  type bots = data list ref 

  (* static datastructure holding all bots and their step functions and handles *)
  let bots =  ref []

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

  (* updates all [bot.others] with the current data list *)
  let rec updateOthers (datalist : data list) = 
    match datalist with 
    | [] -> ()
    | h::t -> h.bot.others <- !bots; updateOthers t

  (* Makes a new bot with a given position, direction, power level and step function
   * [make (xPos,yPos) (xVec,yVec) power] *)
  let make (xPos,yPos) (xVec,yVec) power step = 
    let bot = {
      xPos = xPos;
      yPos = yPos;
      xDir = xVec;
      yDir = yVec;
      speed = 0.0;
      power = power;
      others = !bots;
    } in
    let handle = newHandle () in 
    (* add bot to [bots] *)
    let _ = bots := {handle = handle; bot = bot; step = step}::(!bots) in 
    (* update all bots' [others] list *)
    let _ = updateOthers !bots in
    handle

  (* Updates all bots for a single logic tick *)
  let step () =
    let rec stepall (current : data list) (acc : data list) = 
      match current with
      | [] -> acc
      | h::t -> 
        let _ = h.bot <- (h.step h.bot) in
        stepall t (h::acc)
    in bots := (stepall !bots [])
end
