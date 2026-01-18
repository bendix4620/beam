#import "/tests/utils.typ": test
#import "/src/lib.typ": cetz, prism

// Test symbols
#test({
    prism("prism", (0, 0), (1, 0), (rel: (radius: 1, angle: -20deg)), axis: true)
    cetz.draw.line("prism.in", "prism", "prism.out", stroke: red)
})
