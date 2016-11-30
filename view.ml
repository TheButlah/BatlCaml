open Control

(* type of datastructure maintained by the view *)
type t = Control.t


let rec printBulletInfo bl =
  failwith "Unimplemented"

let rec printBotInfo bl =
  failwith "Unimplemented"

(* print out the informations *)
let printInfo t =
  failwith "Unimplemented"

(* print out the logs *)
let outputLog t =
  failwith "Unimplemented"

(* entry point for program *)
let main =
  init();
  let t = ref (step()) in
  while not (!t).finished do
  	let _ = printInfo !t in
  	t := (step());
  done

let printBotInfo (bot:Bot.t) : unit =
  failwith "Unimplemented"
