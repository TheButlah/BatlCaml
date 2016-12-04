open Control
open Format
open Array
(*open Toploop*)

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

type color = | Black | Red | Green | Yellow | Blue | Magenta | Cyan | White

let setColor (col : color) = 
	let cmd = (
		match col with 
		| Red -> "\033[31m"
		| Green -> "\033[32m"
		| Yellow -> "\033[33m"
		| Blue -> "\033[34m"
		| Magenta -> "\033[35m"
		| Cyan -> "\033[36m"
		| White -> "\033[37m"
		| _ -> "\033[30m")
	in Unix.system ("echo -en \"" ^ cmd ^ "\"")

let setBackground (col : color) = 
	let cmd = (
		match col with 
		| Red -> "\033[41m"
		| Green -> "\033[42m"
		| Yellow -> "\033[43m"
		| Blue -> "\033[44m"
		| Magenta -> "\033[45m"
		| Cyan -> "\033[46m"
		| White -> "\033[47m"
		| _ -> "\033[40m")
	in Sys.command ("echo -en \"" ^ cmd ^ "\"")

let clearColor () = 
	Unix.system "echo -en \"\033[0m\""

let setBold () = 
	Unix.system "echo -en \"\033[1m\""

let printStr str = 
	Unix.system ("echo \"" ^ str ^ "\"")

(* prints an array based on 1s and 0s *)
let printArray a = 
	let size = Array.length a in 
	let size2 = Array.length a.(0) in 
	for i=0 to size-1 do
		for j=0 to size2-1 do
			if a.(i).(j) = 0 
			then let _ = setBackground Black in printStr "  "; clearColor ()
			else if a.(i).(j) = (-1)
			then let _ = setBackground Black in setColor White; printStr " *"; clearColor ()
			else 	
				let color = (
					match a.(i).(j) with
					| x when x = 1 -> Red
					| x when x = 2 -> Yellow
					| x when x = 3 -> Cyan
					| x when x = 4 -> Green
					| _ -> Black
				) in 
				setBackground Black; setColor color; printStr " @"; clearColor ()
		done;
		print_endline ""
	done

(* equivalent of pressing backspace [num] times *)
let rec backspace (num : int) = 
	match num with
	| 0 -> ()
	| _ -> print_string "\b"; backspace (num-1)

(* print out information as dots on a printed grid *)
let printScreen x y (delay : float) (ctrl : Control.t) = 
	let screen = initWindow x y in 
	let size = x in 
	let size2 = y in 
	let rec iter (bots : Control.botInfo list) = (
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
			let hy' = hy *. ratio2 |> int_of_float in 
			let maxpwr = ctrl.maxpower in 
			screen.(hy').(hx') <- h.power/.(maxpwr/.3.) |> int_of_float |> (+) 1;
			iter t
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
			let hy' = hy *. ratio2 |> int_of_float in 
			if screen.(hy').(hx') = 0 then screen.(hy').(hx') <- -1 else ();
			iter2 t
	) in
	iter ctrl.botList;
	iter2 ctrl.bulletList;
  	(* ANSITerminal.set_cursor 1 1; *)
  	(* Sys.command "clear"; *)
  	(* Sys.command "echo -en \"\033[0;0H\""; *)
  	Sys.command "clear";
  	Sys.command "echo -en \"\033[s\"";
  	Thread.delay delay;
	printArray screen

(* print out the logs *)
let outputLog t =
  failwith "Unimplemented"

(* entry point for program *)
let main () =
	Pervasives.print_string "Input a seed to generate the game: ";
	let seedinput = read_line () in
	let seedrandom = (Sys.time ()) *. 1000000. |> int_of_float in 
	let seed = if seedinput = "" then seedrandom else seedinput |> int_of_string in
	Pervasives.print_string seedinput;
	Control.init seed;
	Pervasives.print_string "Enter the number of AI steps per second: ";
	let speed = read_int () in
	let delay = 1. /. (float_of_int speed) in
	Pervasives.print_string "Enter the number of steps to take as an integer. Enter -1 to simulate until completion: ";
	let (widthbefore,heightbefore) = ANSITerminal.size () in
	let (width,height) = (widthbefore/2,heightbefore-2) in 
	let printer = printScreen width height delay in 
	let count = read_int () in 
	if count < 0
	then
		let t = ref (step ()) in
		while not (!t).finished do
			let _ = t := (step ()) in
			printer !t;
		done 
	else 
		let t = ref (step ()) in
		for i = 0 to count do
			let _ = printer !t in
			t := (step ());
		done;
	Sys.command "clear"; printer !t








