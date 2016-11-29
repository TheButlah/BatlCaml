SRCS = bot.byte bullet.byte api.byte ai.byte game.byte view.byte control.byte collisions.byte test.byte

all: $(SRCS)

run: main.byte
	./main.byte

test: test.byte
	./test.byte

%.byte : %.ml
	ocamlbuild -lib dynlink $@

clean:
	ocamlbuild -clean

test.byte:
	ocamlbuild -pkgs oUnit,str,unix test.byte
