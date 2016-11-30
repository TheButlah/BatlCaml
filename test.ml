open OUnit2
open Bot
open Api
open Game

let b1 = Bot.make (10.,10.) (1.,0.) 10. 10. (fun _ -> Api.turnLeft 90.)

let b2 = Bot.make (10.,10.) (1.,0.) 10. 10. (fun _ -> Api.turnLeft 90.)

let b3 = Bot.make (10.,10.) (1.,0.) 10. 10. (fun _ -> Api.turnLeft 90.)

let tests = "test suite" >::: [
  "Forward1" >::
    (fun _ -> assert_equal
      ((20.,10.))
      (let _ = Game.execute (b1) (Api.forward 1.) in getPosition b1));
  "Step1" >::
    (fun _ -> assert_equal
      ((1.,0.))(* (6.12323399573676604e-17, 1.)) *)
      (step (); getDirection b1));
  "Step2" >::
    (fun _ -> assert_equal
      ((-1.83697019872102969e-16, -1.))
      (step (); step (); step (); getDirection b1));
  "LT1" >::
    (fun _ -> assert_equal
      ((-1., 1.22464679914735321e-16))
      (let _ = Game.execute (b2) (Api.turnLeft 180.) in getDirection b2));
  "RT1" >::
    (fun _ -> assert_equal
      ((-1., 1.22464679914735321e-16))
      (let _ = Game.execute (b3) (Api.turnRight 180.) in getDirection b3));
  "Shoot" >::
    (fun _ -> assert_equal
      (1)
      (let _ = Game.execute (b3) (Api.shoot()) in List.length (getBullets())));
  "NoCmd" >::
    (fun _ -> assert_equal
      (b3)
      (Game.execute (b3) (Api.wait())));
]

let _ = run_test_tt_main tests