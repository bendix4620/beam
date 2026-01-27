#import "/tests/utils.typ": test
#import "/src/lib.typ": mirror
#import "/src/dependencies.typ": cetz

#for (i, a) in range(0, 360, step: 30).enumerate() {
    test({
        cetz.draw.translate(y: -1.1)

        let position = ((0, 0), (.5, 0), (rel: (radius: .5, angle: 1deg * a)))
        cetz.draw.line(..position, stroke: red)
        mirror("mirror", ..position, debug: false)
    })
}
