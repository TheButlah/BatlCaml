let link () =
  try
(*    Dynlink.prohibit ["Bullet";"Bot";"Collisions";"Test";"Game";"Control";"View";"Main"];*)
    Dynlink.loadfile_private "_build/ai.cmo";
    Dynlink.loadfile_private "_build/ai2.cmo"
	with
  | Dynlink.Error Dynlink.File_not_found str ->
    print_endline "An AI file could not be found! This likely implies that it did not compile.";
    print_string "The file in question was: "; print_endline str;
    exit 1
  | Dynlink.Error Dynlink.Unavailable_unit str ->
    print_endline "An AI file tried to access a module that was prohibited! Are you cheating?";
    print_string "The unit's name was: "; print_endline str;
    exit 1
  | Dynlink.Error error -> 
    print_endline "Sorry, one or more of the AIs provided caused an error!";
    error |> Dynlink.error_message |> print_endline;
    exit 1
  | _ -> 
    print_endline "Sorry, one or more of the AIs provided are incorrect!";
    exit 1
