open OUnit2
open Bot
open Api
open Game

let b1 = Bot.make (10.,10.) (1.,0.) 10. 10. (fun _ -> Api.turnLeft 90.)
let _ = Game.init [(fun _ -> Api.turnLeft 90.)] 1 1.
let lb = getBots()
let direc = List.hd lb |> getDirection
let get_x direc = let (x,y) = direc in x
let get_y direc = let (x,y) = direc in y

(* Used as function to ~printer to pring out a pair of floats*)
let string_of_tuple tup = 
  let (x,y) = tup in
  "("^(string_of_float x)^","^(string_of_float y)^")"

(* Helper functions to test step *)
let pi = 3.14159265358979324

let toRad (deg : float) = 
  ((mod_float deg 360.)/.360.) *. 2. *. pi

let turn_left deg (x1,y1) = 
    let theta' = mod_float ((atan2 y1 x1) +. toRad deg) (2. *. pi) in
    (cos theta', sin theta')

let tests = "test suite" >::: [
  "Forward1" >::
    (fun _ -> assert_equal
      ~printer: string_of_float 20.
      (let temp = Game.execute (b1) (Api.forward 1.) in get_x (getPosition temp)));
  "Step1a" >::
    (fun _ -> assert_equal
      true
      (cmp_float
      ~epsilon: 0.000001
      (get_x (turn_left 90. direc))
      (step (); get_x (getDirection (List.hd (getBots()))))));
  "Step1b" >::
    (fun _ -> assert_equal
      true
      (cmp_float
      ~epsilon: 0.000001
      (get_y (turn_left 90. direc))
      (step (); get_y (getDirection (List.hd (getBots()))))));
  "Step2a" >::
    (fun _ -> assert_equal
      true
      (cmp_float
      ~epsilon: 0.000001
      (get_x (turn_left 360. direc))
      (step (); step (); step (); get_x (getDirection (List.hd (getBots()))))));
  "Step2b" >::
    (fun _ -> assert_equal
      true
      (cmp_float
      ~epsilon: 0.000001
      (get_y (turn_left 360. direc))
      (step (); step (); step (); get_y (getDirection (List.hd (getBots()))))));
  "LT1" >::
    (fun _ -> assert_equal
      ~printer: string_of_float (-1.)
      (let temp = Game.execute (b1) (Api.turnLeft 180.) in let (x,y) = getDirection temp in x));
  "RT1" >::
    (fun _ -> assert_equal
      ~printer: string_of_float (-1.)
      (let temp = Game.execute (b1) (Api.turnRight 180.) in let (x,y) = getDirection temp in x));
  "Shoot" >::
    (fun _ -> assert_equal
      (1)
      (let _ = Game.execute (b1) (Api.shoot()) in List.length (getBullets())));
  "NoCmd" >::
    (fun _ -> assert_equal
      (getID b1)
      (Game.execute (b1) (Api.wait()) |> getID));
]

let _ = run_test_tt_main tests