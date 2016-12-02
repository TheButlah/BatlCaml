open View
open Control

let _ = Api.wait
let _ = Game.adjustBotPositions
let _ = Apiinternal.wait

let main () =
  Linker.link ();
  print_endline "About to enter view";
  View.main ()
(*   Sdl.init [`VIDEO];
  let _ = Sdlvideo.set_video_mode 800 600 [] in
  Sdltimer.delay 2000;
  Sdl.quit () *)

let _ = main ()
