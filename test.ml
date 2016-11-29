open OUnit2
open Bot

let h1 = Bot.make (10.,10.) (1.,0.) 10. 10.
let _ = assignStep h1 (fun _ -> makeCommand "LT" 90.)

let h2 = Bot.make (10.,10.) (1.,0.) 10. 10.

let h3 = Bot.make (10.,10.) (1.,0.) 10. 10.

let tests = "test suite" >::: [
  "Forward1" >::
    (fun _ -> assert_equal
      ((20.,10.))
      (let _ = Bot.execute (h1) (makeCommand "Forward" 1.) in getPosition h1));
  "Step1" >::
    (fun _ -> assert_equal
      ((6.12323399573676604e-17, 1.))
      (step (); getDirection h1));
  "Step2" >::
    (fun _ -> assert_equal
      ((-1.83697019872102969e-16, -1.))
      (step (); step (); step (); getDirection h1));
  "LT1" >::
    (fun _ -> assert_equal
      ((-1., 1.22464679914735321e-16))
      (let _ = Bot.execute (h2) (makeCommand "LT" 180.) in getDirection h2));
  "RT1" >::
    (fun _ -> assert_equal
      ((-1., 1.22464679914735321e-16))
      (let _ = Bot.execute (h3) (makeCommand "RT" 180.) in getDirection h3));
  "Shoot" >::
    (fun _ -> assert_equal
      (1)
      (let _ = Bot.execute (h3) (makeCommand "Shoot" 0.) in num_bullet ()));
  "NoCmd" >::
    (fun _ -> assert_equal
      (())
      (Bot.execute (h3) (makeCommand "foobar" 0.)));
]

let _ = run_test_tt_main tests