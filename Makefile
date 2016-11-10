SRCS = bot.ml bot.mli bullet.ml bullet.mli ai.ml ai.mli

main: $(SRCS)
	ocamlbuild -pkgs oUnit main.byte

clean:
	ocamlbuild -clean
