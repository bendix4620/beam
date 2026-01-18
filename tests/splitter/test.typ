#import "/tests/utils.typ": test
#import "/src/lib.typ": beam-splitter, beam-splitter-plate
#import "/src/dependencies.typ": cetz

#test({
    import cetz.draw: *
    let position = ((0, 0), (1, 0), (1, 1))
    beam-splitter("bs", ..position, axis: true)
    cetz.draw.line("bs.in", "bs", "bs.out", stroke: red)
})

#test({
    import cetz.draw: *
    let position = ((0, 0), (2, 0))
    beam-splitter("bs", ..position, axis: true)
    cetz.draw.line("bs.in", "bs", "bs.out", stroke: red)
})

#test({
    import cetz.draw: *
    beam-splitter("bs", (0, 0), rotate: 0deg, axis: true, flip: true)
})

#test({
    import cetz.draw: *
    let position = ((0, 0), (.5, 0), (.5, .5))
    beam-splitter-plate("bs", ..position, axis: true)
    cetz.draw.line("bs.in", "bs", "bs.out", stroke: red)
})

#test({
    import cetz.draw: *
    let position = ((0, 0), (1, 0))
    beam-splitter-plate("bs", ..position, axis: true)
    cetz.draw.line("bs.in", "bs", "bs.out", stroke: red)
})

#test({
    import cetz.draw: *
    beam-splitter-plate("bs", (0, 0), rotate: 10deg, axis: true)
})
