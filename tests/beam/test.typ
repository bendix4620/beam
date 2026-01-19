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

#for a in range(0, 90, step: 20).map(i => 1deg * i) {
    test({
        cetz.draw.rotate(a)
        fade("", (), (radius: 1, angle: a), flip: false, global-rotation: a)
    })
}
