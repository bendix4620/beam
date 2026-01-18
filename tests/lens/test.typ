#import "/tests/utils.typ": test
#import "/src/lib.typ": lens

// Test symbols
#for kind in ("()", "((", "))", ")(", "(|", ")|", "|)", "|(", "||") {
    test({
        lens("", (0, 0), kind: kind)
    })
}
