#import "/tests/utils.typ": test
#import "/src/lib.typ": detector
#import "/src/dependencies.typ": cetz

#let angles = range(0, 360, step: 90).map(i => 1deg * i)

// Test symbols
#for a in angles {
    test({
        detector("", (0, 0), rotate: 45deg, label: (
            content: rect(stroke: red)[Label],
            scope: "local",
            pos: a,
        ))
        detector("", (0, 0), rotate: 45deg, label: (
            content: rect(stroke: green)[Label],
            scope: "local",
            pos: a,
            angle: auto,
            padding: .2,
        ))
        detector("", (0, 0), rotate: 45deg, label: (
            content: rect(stroke: blue)[Label],
            scope: "parent",
            pos: a,
        ))
        detector(
            "",
            (0, 0),
            rotate: 45deg,
            label: (
                content: rect[Label],
                scope: "parent",
                pos: a,
                angle: auto,
                padding: .1,
            ),
        )
    })
}

#test({
    detector(
        "",
        (0, 0),
        (1, 1),
        label: (content: rect[Label], pos: "center"),
    )
})
