(* Ryan's AI *)

open Api

exception Break

let pi = 4. *. atan 1.

let targetID = ref min_int
let enemyLastLoc = ref (0.,0.)

(* -360 to 360 exclusive *)
let toDeg (rad : float) =
  ((mod_float rad (2. *. pi))/.(2. *. pi)) *. 360.

let isNear num1 num2 =
  if abs_float (num1-.num2) <= 0.0001 then true else false

let vecToBearing (xDir,yDir) =
  let angle = atan2 yDir xDir in
  let tmp = mod_float (pi *. 0.5 -. angle) (2.*.pi) in  
  if tmp < 0.0 then tmp +. 2.*.pi else tmp

let predictPosWithinBounds time (e:Api.enemy) enemySpeed upperX lowerX upperY lowerY =

  let eBearing = vecToBearing (e.xDir,e.yDir) in
  let predictedX = e.xPos +. enemySpeed*.time*.sin eBearing in
  let predictedY = e.yPos +. enemySpeed*.time*.cos eBearing in
  let dx = predictedX -. e.xPos in
  let dy = predictedY -. e.yPos in

  (* scale down vector if X component is out of bounds *)
  let (predictedX,predictedY) =
  if predictedX>upperX || predictedX<lowerX then
    let diffX = if predictedX>upperX then predictedX-.upperX else (-.predictedX)+.lowerX in
    (* Fix floating point errors when component velocity near zero *)
    let scale = if isNear dx 0.0 then 1.0 else 1.-.abs_float (diffX/.dx) in
    (e.xPos +. dx*.scale ,e.yPos+.dy*.scale)
  else
    (e.xPos +. dx, e.yPos +. dy) in
 
  (* scale down vector if Y component is out of bounds *)
  let (predictedX,predictedY) = 
  if predictedY>upperY || predictedY<lowerY then
    let diffY = if predictedY>upperY then predictedY-.upperY else -.predictedY+.lowerY in
    (* Fix floating point errors when component velocity near zero *)
    let scale = if isNear dy 0.0 then 1.0 else 1.-.abs_float (diffY/.dy) in
    (e.xPos +. dx*.scale ,e.yPos+.dy*.scale)
  else
    (e.xPos +. dx, e.yPos +. dy) in

  (* Just in case...*)
  if classify_float predictedX = FP_nan || classify_float predictedY = FP_nan then
    (* resort to non-bounded prediction *)
    (e.xPos +. enemySpeed*.time*.sin eBearing, e.yPos +. enemySpeed*.time*.cos eBearing)
  else
    (predictedX,predictedY)

let firingSoln (me:Api.bot) (e:Api.enemy) enemySpeed=
  let eBearing = vecToBearing (e.xDir,e.yDir) in 
  let (myX,myY) = getPos me in
  (*let bulletSpeed = getBulletSpeed () in *)
  (* tmp fix because Api.getBulletSpeed doesnt exist in the code submitted *)
  let bulletSpeed = 10.0 in

  let a' = ((e.xPos+.e.xDir*.enemySpeed)-.myX)/.bulletSpeed in
  let b' = (enemySpeed/.bulletSpeed*.sin eBearing) in
  let c' = ((e.yPos+.e.yDir*.enemySpeed)-.myY)/.bulletSpeed in
  let d' = enemySpeed/.bulletSpeed*.cos eBearing in

  let a = a'*.a' +. c'*.c' in
  let b = 2.*.(a'*.b'+.c'*.d') in
  let c = b'*.b'+.d'*.d'-.1. in

  let discriminant = b*.b -. 4.*.a*.c in
  if discriminant >= 0. then
    (* There are two temporal solns *)
    let t1 = 2.*.a/.((-.b) +. sqrt discriminant) in
    let t2 = 2.*.a/.((-.b) -. sqrt discriminant) in

    (* Pick the smaller value *)
    let time = if min t1 t2 >= 0. then min t1 t2 else max t1 t2 in
    let (upperX,upperY) = getRoomSize () in
    let lowerX = 0. in let lowerY = 0. in
    predictPosWithinBounds (time) e enemySpeed upperX lowerX upperY lowerY

  else
    (* Discriminant < 0, unsolvable soln. Resorting to direct targeting *)
    (e.xPos,e.yPos)

let turnToPoint (x,y) (you:Api.bot)=
  let (myX,myY) = getPos you in
  let (xDir,yDir) = getDirection you in
  let dX = x-.myX in
  let dY = y-.myY in
  let angleToPoint = atan2 dY dX in 
  let angle = atan2 yDir xDir in
  let delta = angleToPoint-.angle in
  delta

let isRegenerating = ref false
let shouldRegen (energy:float) =
  if !isRegenerating then
    if energy >= 40. then 
      (isRegenerating := false; false)
    else true
  else
    if energy <=10. then 
      (isRegenerating := true; true)
    else false


let shouldShoot = ref false
let step (you:Api.bot) = try
  begin try
    Api.getEnemies you |> List.find (fun e -> e.id = !targetID) |> ignore
  with
  | Not_found ->
    let enemies = Api.getEnemies you in
    if List.length enemies = 0 then raise Break else
    let newTarget = List.hd enemies in
    targetID := newTarget.id;
    enemyLastLoc := (newTarget.xPos,newTarget.yPos) end;
  let target = Api.getEnemies you |> List.find (fun e->e.id= !targetID) in
  let (lastX,lastY) = !enemyLastLoc in
  let enemySpeed = sqrt (((lastX-.target.xPos)**2.)+.((lastY-.target.yPos)**2.)) in
  enemyLastLoc := (target.xPos,target.yPos);
  if !shouldShoot then (shouldShoot := false; Api.shoot ()) else
  let (predictedX,predictedY) = firingSoln you target enemySpeed in
  let correctionAngle = turnToPoint (predictedX,predictedY) you in
  let angleInDegrees = toDeg correctionAngle in
  if Api.getEnergy you |> shouldRegen then Api.wait () else
  (shouldShoot := true; Api.turnLeft angleInDegrees)
  with
  | Break -> Api.wait ()

let _ = Api.register step
