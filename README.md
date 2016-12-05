# BatlCaml - An AI Programming Game

BatlCaml is a game made by programmers, for programmers. It is a "zero-player game" where instead of sentient players, the players are instead entirely controlled by Artificial Intelligences. Test your coding skills against others by battling your AI units! Whereas many games are written in imperative languages, this one has been written entirely in OCaml, a functional language. This offers players a unique take on developing AI, as the paradigmn is a bit different than traditional languages. 

This game was meant to be played with friends! While there are a few simple AI units included, they are there mostly as examples. So invite them to try their hand at it.

This project is inspired by RoboCode, which is written in Java. If you are wanting for inspiration, take a look at some of the crazy robots people have build for that game!

## Installation

## The API
The main job of the user is to implement a step function of their bot. To do this, you should use the various functions provided by api.mli. A bot’s step function has the type bot -> command, where a command tells the bot whether to turn left, turn right, shoot, move forward, or wait on each step of the simulation. To determine what action to perform, the bot can call functions from the Api module to determine information about themselves and the enemy robots. At the end of each ai file, the user must register their step function by calling the register: (bot -> command) -> unit function in the api.mli file. This ensures that the ai will be loaded into the game. As the good book says:

<code>
Then did he raise on high the Holy AI of BatlCaml, saying, "Bless this, O Lord, that with it thou mayst pew thine enemies to tiny bits, in thy mercy." And the people did rejoice and did feast upon the lambs and toads and tree-sloths and fruit-bats and orangutans and breakfast cereals ... Now did the Lord say, "First thou must calleth the register function. Thou must do this only once. Once shall be the number of the registering and the number of the registering shall be One. Two shalt thou not register, neither shalt thou register zero, excepting that thou then proceedeth to register once. Three is right out. Once the number one, being the number of the registering, be reached, then setteth upon thy Holy AI of BatlCaml in the direction of thine foe, who, being naughty in my sight, shall snuff it." -Book of Camls, Chapter 4, Verses 16 to 20
</code>
