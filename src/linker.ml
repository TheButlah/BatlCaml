exception FailedCompile of string

let link aiDir apiDir =
  try
    let aiFiles = 
      Sys.readdir aiDir |> Array.to_list |>
      List.filter (fun file -> Filename.check_suffix file ".ml") in
    List.iter (fun file -> 
      let result = 
        Sys.command ("ocamlc -c " ^ apiDir ^ "BatlCamlLib.cma "
                     ^ aiDir ^ file) in
      if result<>0 then raise (FailedCompile file) else ()) aiFiles;
    let compiledFiles = 
      Sys.readdir aiDir |> Array.to_list |>
      List.filter (fun file -> Filename.check_suffix file ".cmo") in
    let mapToFilename = List.map Filename.chop_extension in
    let allFilesCompiled = 
      (=) (mapToFilename aiFiles) (mapToFilename compiledFiles) in
    if allFilesCompiled then 
      List.iter (fun file -> aiDir ^ file |> Dynlink.loadfile_private) compiledFiles 
    else raise (FailedCompile "")
 with
  | Dynlink.Error Dynlink.File_not_found str ->
    print_endline "Failed loading AI file! This likely implies that it did not compile.";
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
  | FailedCompile file ->
    print_endline "Failed to compile AI file!";
    exit 1
  | Sys_error error ->
    print_endline "Sorry, we encounted an error when trying to read the AI directory.";
    print_endline "Please ensure that the directory exists and is named properly!";
    print_endline error;
    exit 1
  | _ -> 
    print_endline "Sorry, one or more of the AIs provided are incorrect!";
    exit 1
