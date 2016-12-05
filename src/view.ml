open Control
open Format
open Array

let codelist = ref [] 

(* type of datastructure maintained by the view *)
type t = Control.t

let rec printBulletInfo (bl : Control.bulletInfo list) =
	match bl with 
	| [] -> ()
	| h::t -> 
		let own = h.owner in 
		let (xdir, ydir) = h.dir in 
		Format.printf "[BULLET x:%f y:%f dir:(%f,%f) owner:%i] \n" h.x h.y xdir ydir own;
		printBulletInfo t

let rec printBotInfo (bt : Control.botInfo list) =
	match bt with 
	| [] -> ()
	| h::t -> 
		let (xdir, ydir) = h.dir in 
		Format.printf "[BOT x:%f y:%f dir:(%f,%f) power:%f id:%i] \n" h.x h.y xdir ydir h.power h.id;
		printBotInfo t

(* print out the informations *)
let printInfo t =
	print_string "{ FRAME\n";
	t.finished |> string_of_bool |> print_string; print_newline ();
	printBotInfo t.botList;
	printBulletInfo t.bulletList;
	print_endline "}\n"

(* maks a window *)
let initWindow x y =
	Array.make_matrix y x 0 

(* prints an array based on 1s and 0s *)
let printArray a = 
	let size = Array.length a in 
	let size2 = Array.length a.(0) in 
	for i=0 to size-1 do
		for j=0 to size2-1 do
			if a.(i).(j) = 0 
			then ANSITerminal.print_string [ANSITerminal.on_black; ANSITerminal.white] "  "
			else if a.(i).(j) = (-1)
			then ANSITerminal.print_string [ANSITerminal.on_black; ANSITerminal.white] " *"
			else 	
				let color = (
					match a.(i).(j)/10 with
					| x when x = 1 -> ANSITerminal.red
					| x when x = 2 -> ANSITerminal.yellow
					| x when x = 3 -> ANSITerminal.cyan
					| x when x = 4 -> ANSITerminal.green
					| _ -> ANSITerminal.black
				) in 
				let code = List.nth [" ☂";" ☾";" ♕";" ♂"; " ☿";" ☗";" ☯"] (a.(i).(j) mod 10) in
				ANSITerminal.print_string [ANSITerminal.on_black; color] code;
		done;
		print_endline "";
	done

(* equivalent of pressing backspace [num] times *)
let rec backspace (num : int) = 
	match num with
	| 0 -> ()
	| _ -> print_string "\b"; backspace (num-1)

let round x = 
	x *. 10. |> int_of_float |> float_of_int |> fun x -> x/.10.

let printBotInfoScreen color bot maxpower maxenergy = 
	"BOT" ^ (string_of_int bot.id) ^ "::" |> ANSITerminal.print_string [color];
	let formatpower descr x = 
		if String.length x = 3 then "["^descr^x^"]" else
		if String.length x = 2 then "["^descr^"0"^x^"]" else
		if String.length x = 1 then "["^descr^"00"^x^"]" else "[000]"
	in bot.power |> round |> int_of_float |> string_of_int |> formatpower "PWR "|> ANSITerminal.print_string [color];
	let powerstr = ref "" in 
	let nullstr = ref "" in
	let powerbarlen = 30 in
	let count = ref ((powerbarlen |> float_of_int) *. bot.power/.maxpower |> int_of_float) in
	for i=0 to powerbarlen-1 do 
		if !count > 0 
		then let _ = powerstr := !powerstr ^ "❯" in count := !count - 1
		else nullstr := !nullstr ^ "-"
	done;
	let energystr = ref "" in 
	let nullenstr = ref "" in
	let energybarlen = 30 in
	let count2 = ref ((energybarlen |> float_of_int) *. bot.energy/.maxenergy |> int_of_float) in
	for i=0 to energybarlen-1 do 
		if !count2 > 0 
		then let _ = energystr := !energystr ^ ":" in count2 := !count2 - 1
		else nullenstr := !nullenstr ^ "-"
	done;
	ANSITerminal.print_string [color] "[";
	ANSITerminal.print_string [ANSITerminal.red] !powerstr;
	!nullstr ^ "]" |> ANSITerminal.print_string [color];
	bot.energy |> round |> int_of_float |> string_of_int |> formatpower "EN "|> ANSITerminal.print_string [color];
	ANSITerminal.print_string [color] "[";
	ANSITerminal.print_string [ANSITerminal.green] !energystr;
	!nullenstr ^ "] " |> ANSITerminal.print_string [color];
	ANSITerminal.print_string [color] " x: ";
	bot.x |> round |> string_of_float |> ANSITerminal.print_string [ANSITerminal.black];
	ANSITerminal.print_string [color] " y: ";
	bot.y |> round |> string_of_float |> ANSITerminal.print_string [ANSITerminal.black];
	ANSITerminal.print_string [color] " dir: ";
	let (x, y) = bot.dir in 
	y/.x |> atan |> fun x -> x*.360./.(2.*.3.14159265359) |> round |> string_of_float |>  ANSITerminal.print_string [ANSITerminal.black]
 
let rec printBotsScreen color bots maxpower maxenergy = 
	match bots with 
	| [] -> ()
	| h::[] -> 
		printBotInfoScreen color h maxpower maxenergy; 
		ANSITerminal.erase ANSITerminal.Eol
	| h::t -> 
		printBotInfoScreen color h maxpower maxenergy; 
		ANSITerminal.erase ANSITerminal.Eol; 
		ANSITerminal.print_string [] "\n"; 
		printBotsScreen color t maxpower maxenergy

(* print out information as dots on a printed grid *)
let printScreen x y (delay : float) (ctrl : Control.t) = 
	let screen = initWindow x y in 
	let size = x in 
	let size2 = y in 
	let _ = 
		if !codelist = [] 
		then
			let getRandom x = 
				let i = ref (Random.int 7) in 
				let count = ref 0 in 
				while List.exists (fun y -> !i=y) !codelist && !count <> 7 do
					i := Random.int 7;
					count := !count+1;
				done;
				codelist := !codelist@[!i];
				!i
			in codelist := List.map getRandom ctrl.botList
		else () 
	in 
	let rec iter (bots : Control.botInfo list) count = (
		match bots with
		| [] -> ()
		| h::t -> 
			let hx = h.x in 
			let hy = h.y in 
			let width = ctrl.width in 
			let height = ctrl.height in 
			let sizef = size-1 |> float_of_int in 
			let sizef2 = size2-1 |> float_of_int in 
			let ratio = sizef /. width in 
			let ratio2 = sizef2 /. height in 
			let hx' = hx *. ratio |> int_of_float in 
			let hy' = size2-1-(hy *. ratio2 |> int_of_float) in 
			let maxpwr = ctrl.maxPower in 
			screen.(hy').(hx') <- ((h.power/.(maxpwr/.3.) |> int_of_float)+1)*10 + (List.nth !codelist (count mod 7));
			iter t (count+1)
	) in 
	let rec iter2 (bullets : Control.bulletInfo list) = (
		match bullets with
		| [] -> () 
		| h::t -> 
			let hx = h.x in 
			let hy = h.y in 
			let width = ctrl.width in 
			let height = ctrl.height in 
			let sizef = size-1 |> float_of_int in 
			let sizef2 = size2-1 |> float_of_int in 
			let ratio = sizef /. width in 
			let ratio2 = sizef2 /. height in 
			let hx' = hx *. ratio |> int_of_float in 
			let hy' = size2-1-(hy *. ratio2 |> int_of_float) in 
			if screen.(hy').(hx') = 0 then screen.(hy').(hx') <- -1 else ();
			iter2 t
	) in
	iter ctrl.botList 0;
	iter2 ctrl.bulletList;
	ANSITerminal.set_cursor 1 1;
	print_endline "";
	Unix.sleepf delay;
	printArray screen;
	printBotsScreen ANSITerminal.blue ctrl.botList ctrl.maxPower ctrl.maxEnergy

(* print out the logs *)
let outputLog t =
  failwith "Unimplemented"

(* entry point for program *)
let main () =
	Pervasives.print_string "Input a seed to generate the game: ";
	let seedinput = read_line () in
	let seedrandom = (Sys.time ()) *. 1000000. |> int_of_float in 
	let seed = if seedinput = "" then seedrandom else seedinput |> int_of_string in
	Control.init seed;
	Pervasives.print_string "Enter the number of AI steps per second: ";
	let speed = read_int () in
	let delay = 1. /. (float_of_int speed) in
	Pervasives.print_string "Enter the number of steps to take as an integer. Enter -1 to simulate until completion: ";
	let (widthbefore,heightbefore) = ANSITerminal.size () in
	let (width,height) = (widthbefore/2,heightbefore) in 
	let printer botlength = printScreen width (height-botlength-1) delay in 
	let count = read_int () in 
	let _ = ANSITerminal.erase ANSITerminal.Screen in 
	let t = ref (step ()) in
	let _ = 
		if count < 0
		then
			while not (!t).finished do
				let _ = t := (step ()) in
				printer ((!t).botList |> List.length) !t;
			done
		else 
			for i = 0 to count do
				let _ = t := (step ()) in
				printer ((!t).botList |> List.length) !t;
			done
	in 
	if (List.length !t.botList) = 1 
	then ANSITerminal.print_string [ANSITerminal.cyan] " <- WINNER"
	else ANSITerminal.print_string [ANSITerminal.cyan] "DRAW";
	print_endline ""; print_string "\n"






