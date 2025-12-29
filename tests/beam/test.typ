#import "/tests/utils.typ": test
#import "/src/lib.typ": beam, cetz, fade, focus

// Test symbols
#test({
    beam("", (), (1, 0), (2, 1), (2, 2))
    // introduce some spacing
    cetz.draw.content((2.5, -.5), [])
})

#test({
    beam("", (0, 0), (1, 0))
    focus("", ".end", (3, 0))
})

#test({
    cetz.draw.rotate(85deg)
    // cetz.draw.scale(.5)
    beam("", (-1, 0), (0, 0))
    fade("", (0, 0), (1, 0))
})
