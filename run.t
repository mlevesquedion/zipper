  $ dune build @install @runtest --display short
      ocamldep lib/.zipper.objs/zipper.ml.d
        ocamlc lib/.zipper.objs/byte/zipper.{cmi,cmo,cmt}
        ocamlc lib/zipper.cma
      ocamldep test/.test.eobjs/test.ml.d
      ocamlopt lib/.zipper.objs/native/zipper.{cmx,o}
      ocamlopt lib/zipper.{a,cmxa}
        ocamlc test/.test.eobjs/byte/test.{cmi,cmo,cmt}
      ocamlopt test/.test.eobjs/native/test.{cmx,o}
      ocamlopt test/test.exe
          test test/test.output
      ocamlopt lib/zipper.cmxs
