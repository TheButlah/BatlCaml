#Do not put test in the variable below.
SRCS = bot bullet api ai game view control collisions main
#SRCS = bot.byte bullet.byte api.byte ai.byte game.byte view.byte control.byte collisions.byte test.byte

all: $(SRCS)
	ocamlbuild -pkgs oUnit,sdl -libs dynlink test.byte

run: main
	./main.byte

$(SRCS):
	ocamlbuild -pkgs oUnit,sdl -libs dynlink $@.byte

test: 
	ocamlbuild -pkgs oUnit,sdl -libs dynlink && ./test.byte

clean:
	ocamlbuild -clean

