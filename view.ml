open Control
open Format

(* type of datastructure maintained by the view *)
type t = Control.t

let rec printBulletInfo (bl : Control.bulletInfo list) =
	match bl with 
	| [] -> ()
	| h::t -> 
		let (xdir, ydir) = h.dir in 
		Format.printf "[BULLET x:%f y:%f dir:(%f,%f) owner:%i] " h.x h.y xdir ydir h.owner;
		printBulletInfo t

let rec printBotInfo (bt : Control.botInfo list) =
	match bt with 
	| [] -> ()
	| h::t -> 
		let (xdir, ydir) = h.dir in 
		Format.printf "[BOT x:%f y:%f dir:(%f,%f) id:%i] " h.x h.y xdir ydir h.id;
		printBotInfo t

(* print out the informations *)
let printInfo t =
	print_string "{ FRAME\n";
	string_of_bool t.finished |> print_string; print_newline ();
	printBotInfo t.botList; print_newline ();
	printBulletInfo t.bulletList; print_newline ();
	print_endline "}\n"

(* print out the logs *)
let outputLog t =
  failwith "Unimplemented"

(* entry point for program *)
let main =
	init();
	print_string("Enter the number of steps to take as an integer. Enter -1 to simulate until completion: ");
	let count = read_int () in 
	if count < 0
	then
		let t = ref (step()) in
		while not (!t).finished do
			let _ = printInfo !t in
			t := (step());
		done
	else 
		let t = ref (step()) in
		for i = 0 to count do
			let _ = printInfo !t in
			t := (step());
		done


let printBotInfo (bot:Bot.t) : unit =
  failwith "Unimplemented"
