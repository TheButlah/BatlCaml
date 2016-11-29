SRCS = bot.byte api.byte ai.byte game.byte view.byte control.byte

all: $(SRCS)

run: main.byte
	./main.byte

%.byte : %.ml
	ocamlbuild -lib dynlink $@

clean:
	ocamlbuild -clean
