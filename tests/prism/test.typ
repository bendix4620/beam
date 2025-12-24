#import "/tests/utils.typ": test
#import "/src/lib.typ": prism, cetz

// Test symbols
#test({
  prism("", (0, 0), (1, 0), (rel: (radius: 1, angle: -20deg)), axis: true)
  cetz.draw.line(".src", "", ".dst", stroke: red)
})
