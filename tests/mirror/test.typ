#import "/tests/utils.typ": test
#import "/src/lib.typ": flip-mirror, grating, mirror

// Test symbols
#test({
    mirror("", (0, 0), kind: "|")
    mirror("", (1, 0), kind: ")")
    mirror("", (2, 0), kind: "(")
})
#test({
    mirror("", (0, 0), (1, 0), (1, 1))
})

#test({
    flip-mirror("", (0, 0), (1, 0), (1, 1))
})

#test({
    grating("", (0, 0), (1, 0), (1, 1))
})
