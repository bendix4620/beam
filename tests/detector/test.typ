#import "/tests/utils.typ": test
#import "/src/lib.typ": detector

// Test symbols
#test({
    detector("", (0, 0), (1, 0))
})
