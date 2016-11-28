SRCS = bot.ml bot.mli ai.ml ai.mli api.ml api.mli game.ml game.mli

main: $(SRCS)
	ocamlbuild -pkgs oUnit main.byte

clean:
	ocamlbuild -clean
