SRCS = bot.ml bot.mli api.ml api.mli ai.ml ai.mli game.ml game.mli

main: $(SRCS)
	ocamlbuild -pkgs oUnit main.byte 

clean:
	ocamlbuild -clean

test:
	ocamlbuild -pkgs oUnit,str,unix test.byte && ./test.byte