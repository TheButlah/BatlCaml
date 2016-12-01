#Do not put test in the variable below.
SRCS = bot linker apiexternal bullet api game view control collisions main
#SRCS = bot.byte bullet.byte api.byte ai.byte game.byte view.byte control.byte collisions.byte test.byte
LIBS = dynlink 
PKGS = oUnit,ANSITerminal
AI = ai ai2
#PKGS = oUnit,sdl,bigarray,sdl.sdlttf,sdl.sdlimage,sdl.sdlmixer
#PKGS = oUnit,tsdl

all: $(SRCS) $(AI)
	ocamlbuild -tag thread -pkgs $(PKGS) -libs $(LIBS) test.byte

$(AI):
	ocamlbuild ai/$@.cmo

run: main
	./main.byte

$(SRCS):
	ocamlbuild -tag thread -pkgs $(PKGS) -libs $(LIBS) $@.byte

test: 
	ocamlbuild -tag thread -pkgs $(PKGS) -libs $(LIBS) && ./test.byte

clean:
	ocamlbuild -clean

