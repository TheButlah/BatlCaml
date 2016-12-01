#Do not put test in the variable below.
SRCS = bot bullet api ai game view control collisions main
#SRCS = bot.byte bullet.byte api.byte ai.byte game.byte view.byte control.byte collisions.byte test.byte
LIBS = dynlink 
PKGS = oUnit,ANSITerminal
#PKGS = oUnit,sdl,bigarray,sdl.sdlttf,sdl.sdlimage,sdl.sdlmixer
#PKGS = oUnit,tsdl

all: $(SRCS)
	ocamlbuild -tag thread -pkgs $(PKGS) -libs $(LIBS) test.byte

run: main
	./main.byte

$(SRCS):
	ocamlbuild -tag thread -pkgs $(PKGS) -libs $(LIBS) $@.byte

test: 
	ocamlbuild -tag thread -pkgs $(PKGS) -libs $(LIBS) && ./test.byte

clean:
	ocamlbuild -clean

