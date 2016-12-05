open OUnit2
open Api

let setupGame () =
  Game.init [(fun _ -> Api.turnLeft 90.)] 1 1. 1. 1. 1. 1. (fun x -> 0.0) 1. 1. 1. 1. 1.;
  Bot.make (10.,10.) (1.,0.) 10. 10. 10. 1. 1. (fun _ -> Api.turnLeft 90.)


let get_x = fst
let get_y = snd

(* Used as function to ~printer to pring out a pair of floats*)
let string_of_tuple tup = 
  let (x,y) = tup in
  "("^(string_of_float x)^","^(string_of_float y)^")"

let direc () = 
  let lb = Game.getBots() in
  List.hd lb |> getDirection

(* Helper functions to test step *)
let pi = 4. *. atan 1.

(* Returns -2pi to 2pi exclusive*)
let toRad (deg : float) = 
  ((mod_float deg 360.)/.360.) *. 2. *. pi

let turn_left deg (x1,y1) =
  let theta' = mod_float ((atan2 y1 x1) +. toRad deg) (2. *. pi) in
  (cos theta', sin theta')

let tests = "test suite" >::: [
  "Forward1x" >::
    (fun _ -> 
      let b1 = setupGame () in
      assert_equal ~printer: string_of_float 
      20.
      (Game.execute (b1) (Api.forward 1.) |> Bot.getPosition |> get_x));
  "Forward1y" >::
    (fun _ ->
      let b1 = setupGame () in
      assert_equal ~printer: string_of_float 
      10.
      (Game.execute (b1) (Api.forward 1.) |> Bot.getPosition |> get_y));
  "Step1x" >::
    (fun _ -> 
      let _ = setupGame () in
      direc () |> string_of_tuple |> print_endline;
      let e1 = (direc () |> turn_left 90. |> get_x ) in
      let e2 = (Game.step (); direc () |> get_x) in
      assert_equal ~printer:string_of_float e1 e2);
  (*    true
      (cmp_float ~epsilon: 0.0001*)
  "Step1y" >::
    (fun _ ->
      let _ = setupGame() in
      let e1 = (direc () |> turn_left 90. |> get_y ) in
      let e2 = (Game.step (); direc () |> get_y) in
      assert_equal ~printer: string_of_bool 
      true (cmp_float ~epsilon: 0.000001 e1 e2));
   (*   true
      (cmp_float ~epsilon: 0.01 *)
  "Step2x" >::
    (fun _ -> 
      let _ = setupGame () in
      let e1 = (direc () |> turn_left 360. |> get_x) in
      let e2 = Game.(step (); step (); step (); step (); direc () |> get_x) in
      assert_equal ~printer: string_of_bool
      true (cmp_float ~epsilon: 0.000001 e1 e2));
  "Step2y" >::
    (fun _ -> 
      let _ = setupGame () in
      let e1 = (direc () |> turn_left 360. |> get_y) in
      let e2 = Game.(step (); step (); step (); step (); direc () |> get_y) in
      assert_equal ~printer: string_of_bool
      true (cmp_float ~epsilon: 0.000001 e1 e2));
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
      (Game.execute (b1) (Api.shoot()) |> ignore ; Game.getBullets () |> List.length));
  "Wait" >::
    (fun _ -> 
      let b1 = setupGame () in
      let e1 = (getID b1) in
      let e2 = (Game.execute (b1) (Api.wait()) |> getID) in
      assert_equal ~printer: string_of_int e1 e2);
]

let _ = run_test_tt_main tests
