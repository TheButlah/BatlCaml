open OUnit2
open Bot
open Api
open Game

let setupGame () =
  Game.init [(fun _ -> Api.turnLeft 90.)] 1 1. 1. 1. 1. 1. 1. 1. 1.;
  Bot.make (10.,10.) (1.,0.) 10. 10. 1. 1. (fun _ -> Api.turnLeft 90.)

let direc () = 
  let lb = getBots() in
  List.hd lb |> getDirection

let get_x = fst
let get_y = snd

(* Used as function to ~printer to pring out a pair of floats*)
let string_of_tuple tup = 
  let (x,y) = tup in
  "("^(string_of_float x)^","^(string_of_float y)^")"

(* Helper functions to test step *)
let pi = 4. *. atan 1.

(* Returns -2pi to 2pi exclusive*)
let toRad (deg : float) = 
  let result = ((mod_float deg 360.)/.360.) *. 2. *. pi in
  print_endline ("toRad: " ^ string_of_float deg ^ " -> " ^ string_of_float result);
  result

let turn_left deg (x1,y1) =

  let theta' = mod_float ((atan2 y1 x1) +. toRad deg) (2. *. pi) in
  let (x,y) = (cos theta', sin theta') in
  print_endline ("turn_left " ^ string_of_float deg^" "^string_of_tuple (x1,y1)^" -> "^string_of_tuple (x,y));
  (x,y)

let tests = "test suite" >::: [
  "Forward1x" >::
    (fun _ -> 
      let b1 = setupGame () in
      assert_equal ~printer: string_of_float 
      20.
      (Game.execute (b1) (Api.forward 1.) |> getPosition |> get_x));
  "Forward1y" >::
    (fun _ -> 
      let b1 = setupGame () in
      assert_equal ~printer: string_of_float 
      10.
      (Game.execute (b1) (Api.forward 1.) |> getPosition |> get_y));
  "Step1x" >::
    (fun _ -> 
      let _ = setupGame () in
      direc () |> string_of_tuple |> print_endline;
      assert_equal ~printer: string_of_float
  (*    true
      (cmp_float ~epsilon: 0.0001*)
      (direc () |> turn_left 90. |> get_x )
      (step (); direc () |> get_x));
  "Step1y" >::
    (fun _ -> 
      let _ = setupGame() in
      assert_equal ~printer: string_of_float
   (*   true
      (cmp_float ~epsilon: 0.01 *)
      (direc () |> turn_left 90. |> get_y )
      (step (); direc () |> get_y));
  "Step2x" >::
    (fun _ -> 
      let _ = setupGame () in
      assert_equal ~printer: string_of_bool
      true
      (cmp_float ~epsilon: 0.01
      (direc () |> turn_left 360. |> get_x)
      (step (); step (); step (); step (); direc () |> get_x)));
  "Step2y" >::
    (fun _ -> 
      let _ = setupGame () in
      assert_equal ~printer: string_of_bool
      true
      (cmp_float ~epsilon: 0.000001
      (direc () |> turn_left 360. |> get_y)
      (step (); step (); step (); step (); direc () |> get_y)));
  "LT1" >::
    (fun _ -> 
      let b1 = setupGame() in
      assert_equal ~printer: string_of_float 
      (-1.)
      (Game.execute (b1) (Api.turnLeft 180.) |> getDirection |> get_x));
  "RT1" >::
    (fun _ -> 
      let b1 = setupGame() in
      assert_equal ~printer: string_of_float 
      (-1.)
      (Game.execute (b1) (Api.turnRight 180.) |> getDirection |> get_x));
  "Shoot" >::
    (fun _ -> 
      let b1 = setupGame () in
      assert_equal ~printer: string_of_int
      1
      (Game.execute (b1) (Api.shoot()) |> ignore ; getBullets () |> List.length));
  "Wait" >::
    (fun _ -> 
      let b1 = setupGame () in
      assert_equal ~printer: string_of_int
      (getID b1)
      (Game.execute (b1) (Api.wait()) |> getID));
]

let _ = run_test_tt_main tests
