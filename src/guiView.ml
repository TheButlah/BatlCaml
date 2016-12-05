open Tsdl

type t = Control.t

let width = 1280
let height = 720
let title = "BatlCaml"

let main () = 
  at_exit Sdl.quit;
  match Sdl.init Sdl.Init.(video + audio) with
  | Error (`Msg e) -> Sdl.log "Init error: %s" e; exit 1
  | Ok () ->
    match Sdl.create_window ~w:width ~h:height title Sdl.Window.opengl with
    | Error (`Msg e) -> Sdl.log "Create window error: %s" e; exit 1
    | Ok w ->
      Sdl.delay 3000l;
      Sdl.destroy_window w;
      exit 0
