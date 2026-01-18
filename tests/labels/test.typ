#import "/tests/utils.typ": test
#import "/src/lib.typ": filter
#import "/src/dependencies.typ": cetz

// Test symbols
#for i in range(0, 180, step: 45) {
    test({
        cetz.draw.rotate(.5deg * i)
        filter("", (0, 0), rotate: .5deg * i, label: (content: [Label], scope: "local"))
    })

    test({
        cetz.draw.rotate(.5deg * i)
        filter("", (0, 0), rotate: .5deg * i, label: (content: [Label], scope: "parent"))
    })

    test({
        cetz.draw.rotate(.5deg * i)
        filter("", (0, 0), rotate: .5deg * i, label: (content: [Label], scope: "global"))
    })
}
