#import "/src/anchor.typ" as anchor_
#import "/src/dependencies.typ": cetz
#import cetz: matrix, vector
#set page(width: auto, height: auto, margin: 5pt)

#let tol = 1e-8

#let test-normalize-angle(
    test-angles: range(0, 360, step: 10).map(it => 1deg * it),
    test-offsets: range(-5, 5 + 1).map(it => 360deg * it),
) = {
    for a in test-angles {
        for o in test-offsets {
            let res = anchor_.normalize-angle(a + o)
            assert(
                (res - a).deg() < tol,
                message: repr((res: res, init: a, offset: o)),
            )
        }
    }
}

#test-normalize-angle()

#let test-angle-anchor-conversion(
    test-anchors: ("north", "north-east", "east", "south-east", "south", "south-west", "west", "north-west"),
) = {
    for should in test-anchors {
        let angle = anchor_.anchor-to-angle(should)
        let res = anchor_.angle-to-anchor(angle)
        assert.eq(
            should,
            res,
            message: repr((should: should, res: res, angle: angle)),
        )
    }
}

#test-angle-anchor-conversion()

#let test-opposite-anchor-conversion(
    test-anchors: ("north", "north-east", "east", "south-east", "south", "south-west", "west", "north-west"),
) = {
    for should in test-anchors {
        let tmp = anchor_.opposite-anchor(should)
        let res = anchor_.opposite-anchor(tmp)
        assert.eq(
            should,
            res,
            message: repr((should: should, res: res, opposite: tmp)),
        )
    }
}

#test-opposite-anchor-conversion()
