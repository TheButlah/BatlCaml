#Do not put test in the variable below.
SRCS = bot bullet api ai game view control collisions
#SRCS = bot.byte bullet.byte api.byte ai.byte game.byte view.byte control.byte collisions.byte test.byte

all: $(SRCS)
	ocamlbuild -pkg oUnit -lib dynlink test.byte

$(SRCS):
	ocamlbuild -pkg oUnit -lib dynlink $@.byte

test: 
	ocamlbuild -pkg oUnit -lib dynlink test.byte && ./test.byte

clean:
	ocamlbuild -clean

