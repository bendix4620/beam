#import "/tests/utils.typ": test
#import "/src/lib.typ": cetz.draw.line, filter, filter-rot

// Test symbols
#test({
    filter("", (0, 0))
})

#test({
    filter-rot("fw", (0, 0))
    line("fw.in", "fw", "fw.o", "fw.out", stroke: red)
})
