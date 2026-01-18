#import "/tests/utils.typ": test
#import "/src/lib.typ": beam, filter, filter-rot

// Test symbols
#test({
    filter("", (0, 0))
})

#test({
    filter-rot("", (0, 0))
})
