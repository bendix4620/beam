#import "/tests/utils.typ": test
#import "/src/lib.typ": mirror, flip-mirror, grating

// Test symbols
#test({
  mirror("", (0, 0), (1, 0), (1, 1))
})

#test({
  flip-mirror("", (0, 0), (1, 0), (1, 1))
})

#test({
  grating("", (0, 0), (1, 0), (1, 1))
})
