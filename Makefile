.PHONY: all clean

all: icfp_dir.ml
	ocamlbuild -use-ocamlfind icfp_dir.native

clean:
	rm -rf _build

depends:
	opam install -y github tls cmdliner astring

deploy:
	make all && git checkout master && ./icfp_dir.native -c private ocamllabs/icfp2016-blog
