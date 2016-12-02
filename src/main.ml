open View
open Control

let _ = Api.wait
let _ = Game.adjustBotPositions
let _ = Apiinternal.wait

let aiDir = "src/ai/"
let apiDir = "_build/src/lib/"

let main () =
  at_exit (fun _ -> Sys.command ("rm -f "^aiDir^"*.cm* &> /dev/null") |> ignore);
  Sys.catch_break true;
 
  Linker.link aiDir apiDir;
  print_endline "About to enter view";
  View.main ()
(*   Sdl.init [`VIDEO];
  let _ = Sdlvideo.set_video_mode 800 600 [] in
  Sdltimer.delay 2000;
  Sdl.quit () *)

let _ = try 
  main ()
with
| _ -> exit 1
