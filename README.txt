BatlCaml - An AI Programming Game
=================================
BatlCaml is a game made by programmers, for programmers. It is a "zero-player game" where instead of sentient players, the players are instead entirely controlled by Artificial Intelligences. Test your coding skills against others by battling your AI units! Whereas many games are written in imperative languages, this one has been written entirely in OCaml, a functional language. This offers players a unique take on developing AI, as the paradigmn is a bit different than traditional languages. 

This game was meant to be played with friends! While there are a few simple AI units included, they are there mostly as examples. So invite them to try their hand at it.

This project is inspired by RoboCode, which is written in Java. If you are wanting for inspiration, take a look at some of the crazy robots people have built for that game, and try to implement them in OCaml!

Installation
------------
First, you will need to ensure that you have OPAM, the ocaml package manager installed, and running OCaml 4.03.0. While it is likely that later versions of OCaml will also work, this is the version that was used at the time of development. Additionally, the project has only been tested on Ubuntu 16.10 and 16.04 as well as Mac OSX. Windows is not officially supported, but feel free to try your luck!
Next, we will need to install some OPAM packages. Run the following:

opam install ANSITerminal oUnit oasis

Once you have ensured that these have installed correctly (you may have to install system packages as well as opam packages!) then you may clone this repo. From the folder that you just cloned, run the following commands:

oasis setup -setup-update dynamic
./configure --prefix=$(opam config var prefix)
make
make install

Make sure that there were no errors. If so, then you are ready to run BatlCaml! You can invoke the BatlCaml command in your terminal in any directory, but in order for the program to actually run, you will need a folder in your current working directory named ai with at least two .ml files with valid AI units inside each. A few examples are provided in the ai folder that came with this repo, so try it out with those!
You can quit the game at any time with ctrl-c. Do not use ctrl-z or any other control sequences because at shutdown the game removes all compiled ocaml files from the ai directory for sanitary purposes. If you accidentally do this and BatlCaml complains, dont fret! Simply remove all the *.cmo and *.cmi files from the ai folder and try again.

The API
-------
The main job of the user is to implement a step function of their bot. To do this, you should use the various functions provided by api.mli. A bot’s step function has the type bot -> command, where a command tells the bot whether to turn left, turn right, shoot, move forward, or wait on each step of the simulation. To determine what action to perform, the bot can call functions from the Api module to determine information about themselves and the enemy robots. At the end of each ai file, the user must register their step function by calling the register: (bot -command) -> unit function in the api.mli file. This ensures that the ai will be loaded into the game. As the good book says:

Then did he raise on high the Holy AI of BatlCaml, saying, "Bless this, O Lord, that with it thou mayst pew thine enemies to tiny bits, in thy mercy." And the people did rejoice and did feast upon the lambs and toads and tree-sloths and fruit-bats and orangutans and breakfast cereals ... Now did the Lord say, "First thou must calleth the register function. Thou must do this only once. Once shall be the number of the registering and the number of the registering shall be One. Two shalt thou not register, neither shalt thou register zero, excepting that thou then proceedeth to register once. Three is right out. Once the number one, being the number of the registering, be reached, then setteth upon thy Holy AI of BatlCaml in the direction of thine foe, who, being naughty in my sight, shall snuff it." -Book of Camls, Chapter 4, Verses 16 to 20

It is also important to note that your code will not be able to access any of the other modules in the BatlCaml program other than Api. This is in order to prevent users from cheating, and to keep the code of each individual AI separate from each other.

Once you have your collection of various AIs that you want, simply put them in a folder called ai. Then invoke BatlCaml from outside this folder. Each file in the folder will then be instantiated in the simulation as an AI unit.
