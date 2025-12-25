#import "/tests/utils.typ": test
#import "/src/lib.typ": beam, laser, mirror, objective

// Test symbols
#test({
    laser("laser", ())
    mirror("mirror", "laser", (3, 0), (4, 2))
    objective("obj", "mirror", "mirror.dst")
    beam("", "laser", "mirror", "obj")
})
