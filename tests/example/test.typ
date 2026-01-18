#import "/tests/utils.typ": test
#import "/src/lib.typ": *
#import cetz.draw: *

#test({
    laser("laser", (0, 0))
    lens("l1", (1, 0))
    detector("cam", (2, 0))
    beam("", "laser", "l1")
    focus("", "l1", "cam")
})

#test({
    set-beam-style(
        beam: (stroke: 11pt + purple),
        detector: (fill: red.darken(50%)),
    )

    laser("laser", (0, 0), fill: navy)
    lens("l1", (1, 0), scale: 1.5)
    detector("cam", (2, 0))
    beam("", "laser", "l1")
    focus("", "l1", "cam")
})

#test({
    set-beam-style(beam: (stroke: (thickness: 1pt, dash: "solid")))

    beam-splitter("bs", (0, 0), flip: true)
    laser("laser", (-2, 0))
    detector("cam", (0, -2), rotate: -90deg)
    mirror("m1", (0, 2), rotate: -90deg)
    mirror("m2", (2.5, 0), rotate: 180deg)

    draw.line((rel: (.7, 0)), (rel: (.5, 0)), mark: (symbol: ">", anchor: "base", stroke: black, fill: black))
    beam("", "laser", "m2")
    beam("", "m1", "cam")

    set-style(mark: (fill: green, stroke: 0pt, scale: 1.2))
    move-to("bs")
    for c in ("m1", "m2", "laser") {
        mark(("bs", .75, c), "bs", ">")
    }
    for c in ("m1", "m2", "cam") {
        mark((c, .5, "bs"), "bs", "<")
    }
})


#let custom(name, ..params) = {
    let w = 2
    let h = 1

    let sketch(ctx, points, style) = {
        interface(
            (-w / 2, -h / 2),
            (w / 2, h / 2),
            io: points.len() < 2,
        )

        rect("bounds.north-east", "bounds.south-west", ..style)
    }
    component("my-custom-component", sketch: sketch, name, ..params)
}

#test({
    custom("c", (0, 0), (3, 0))
    beam("", "c.in", "c.out")
})
