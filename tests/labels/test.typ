#import "/tests/utils.typ": test
#import "/src/lib.typ": filter

// Test symbols

#for i in range(0, 180, step: 45) {
  test({
    filter("", (0, 0), rotate: 1deg*i, label: (content: [Label]))
  })

  test({
    filter("", (0, 0), rotate: 1deg*i, label: (content: [Label], at: "east"))
  })
}
