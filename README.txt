Overview:

Our project aims to design a “zero-player game” where players use an API we provide to write OCaml code that controls the behavior of virtual robots. These virtual robots would resemble tanks, and would compete by fighting each other until their opponent is destroyed. This project is inspired by RoboCode, which is written in Java. Once users write their code (using external tools), the game will then load their code and the code of a user chosen opponent. In our first prototype, the user will follow the simulation by reading text-based output displayed after every step of the simulation. If time allows, a 2D, top-down view of the battle arena will be shown to the user, where the two robots will be placed in a random location and orientation. They will then execute the code that the user provided, causing the robots to fight. Whichever robot remains alive is the winner. The aspect of the game that will be interesting to users is refining the AI code to develop more complex and successful robots. 


Key Features:

	- Provide users with an OCaml API to code robots
	- Design the behavior of robots using OCaml code
	- Test your robot AI against preprogrammed designs, and other user-submitted designs in a simulated battle environment
	- Provide users a command-line application to view the robot battle simulation
	- Be able to have the program compile and run user code, rather than users being required to do this


Using the API:

The main job of the user is to implement a step function of their bot in an ai.ml file. To do this, the user will use the various functions provided by api.mli. A bot’s step function has the type bot -> command, where a command tells the bot whether to turn left, turn right, shoot, move forward, or wait on each step of the simulation. To determine what action to perform, the bot can call functions from api.mli to determine information about themselves and the enemy robots. At the end of each ai file, the user must register their step function by calling the register: (bot -> command) -> unit function in the api.mli file. This ensures that the ai will be loaded into the game.