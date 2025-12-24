#import "/tests/utils.typ": test
#import "/src/lib.typ": beam-splitter, beam-splitter-plate
#import "/src/dependencies.typ": cetz

#test({
  import cetz.draw: *
  let position = ((0, 0), (1, 0), (1, 1))
  beam-splitter("bs", ..position, debug: false, axis: true)
  cetz.draw.line("bs.src", "bs", "bs.dst", stroke: red)
})

#test({
  import cetz.draw: *
  let position = ((0, 0), (2, 0))
  beam-splitter("bs", ..position, debug: false, axis: true)
  cetz.draw.line("bs.src", "bs", "bs.dst", stroke: red)
})

#test({
  import cetz.draw: *
  beam-splitter("bs", (0, 0), rotate: 45deg, debug: false, axis: true, flip: true)
  cetz.draw.line("bs.src", "bs", "bs.dst", stroke: red)
})

#test({
  import cetz.draw: *
  let position = ((0, 0), (1, 0), (1, 1))
  beam-splitter-plate("bs", ..position, debug: false, axis: true)
  cetz.draw.line("bs.src", "bs", "bs.dst", stroke: red)
})

#test({
  import cetz.draw: *
  let position = ((0, 0), (2, 0))
  beam-splitter-plate("bs", ..position, debug: false, axis: true)
  cetz.draw.line("bs.src", "bs", "bs.dst", stroke: red)
})

#test({
  import cetz.draw: *
  beam-splitter-plate("bs", (0, 0), rotate: 20deg, debug: false, axis: true, flip: true)
  cetz.draw.line("bs.src", "bs", "bs.dst", stroke: red)
})
