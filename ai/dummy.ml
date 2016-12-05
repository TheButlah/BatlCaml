open Api

let turned = ref false
let shot = ref false

let step you = 
  Api.wait ()

let _ = register step
