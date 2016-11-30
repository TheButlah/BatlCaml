open Ai
open Bot

let main () =
  Sdl.init [`VIDEO];
  let _ = Sdlvideo.set_video_mode 800 600 [] in
  Sdltimer.delay 2000;
  Sdl.quit ()

let _ = main ()
