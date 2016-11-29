SRCS = bot.byte bullet.byte api.byte ai.byte game.byte view.byte control.byte

all: $(SRCS)

run: main.byte
	./main.byte

%.byte : %.ml
	ocamlbuild -lib dynlink $@

clean:
	ocamlbuild -clean

test:
	ocamlbuild -pkgs oUnit,str,unix test.byte && ./test.byte