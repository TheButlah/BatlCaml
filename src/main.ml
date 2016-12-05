(*load each module so that Dynlink doesn't throw an error when linking *)
let _ = Api.wait
(*let _ = Game.adjustBotPositions*)
(*let _ = Apiinternal.wait*)


(*let aiDir = "src/ai/"
let apiDir = "_build/src/lib/"*)
let aiDir = "ai/"

let main () =
  at_exit (fun _ -> 
    Sys.command ("rm -f "^aiDir^"*.cm* &> /dev/null") |> ignore;
    print_newline ());
  Sys.catch_break true;
 
  Linker.link aiDir;
  GuiView.main()
  (*ConsoleView.main ()*)
(*   Sdl.init [`VIDEO];
  let _ = Sdlvideo.set_video_mode 800 600 [] in
  Sdltimer.delay 2000;
  Sdl.quit () *)

let _ = 
  try 
    main ()
  with
  | Sys.Break -> exit 1
  | e -> Printexc.to_string e |> print_endline; exit 1
