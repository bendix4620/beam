#import "/tests/utils.typ": test
#import "/src/lib.typ"

// Test CeTZ components styling
#test({
    import lib: *
    set-beam-style(stroke: 3pt + red)

    draw.rect((0, 0), (1, 1))
    lens("", (1.5, .5))
})
