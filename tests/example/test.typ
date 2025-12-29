#import "/tests/utils.typ": test
#import "/src/lib.typ": *
#import cetz: draw


#let light-detection() = {
    cetz.draw.anchor("in", (0, 0))

    flip-mirror("m1", (0, 1.8), rotate: -45deg)
    mirror("m2", (), (rel: (6, 0)), (rel: (-1, -1)))
    mirror("m3", "m2", "m2.dst", (rel: (0, 4)))
    flip-mirror("m4", "m3.dst", rotate: 225deg)
    mirror("m5", (horizontal: ("m1", 30%, "m2"), vertical: ()), rotate: -45deg)
    flip-mirror("m6", (horizontal: (), vertical: "m1"), rotate: 225deg)

    flip-mirror("m7", (horizontal: "m1", vertical: ("m2", 50%, "m4")), rotate: -45deg)
    prism("prism", "m7", (horizontal: ("m5", 50%, "m4"), vertical: ()), (to: "m4", rel: (1, 0)))
    mirror("m8", "prism", "prism.dst", "m5")

    lens("lens", "m4", "m5", position: 70%)

    detector("cam", (to: "m6", rel: (0, -.8)), rotate: -90deg)
    cetz.draw.anchor("out", (to: "m7", rel: (0, 2)))

    cetz.draw.content("cam.north", [EMCCD], anchor: "north")
    cetz.draw.content("prism.west", [prism], anchor: "north", padding: (top: 0.2, right: 0.5))

    beam("", "in", "m1", "m2", "m3", "m4", "m5", "cam", mark: (end: ">>", stroke: (dash: "solid")))
    beam("", "m1", "m7", "prism", "m8", "m4")
    beam("", "m7", "out")
}

#let photon-counting() = {
    cetz.draw.anchor("in", (0, 0))

    pinhole("ph", (rel: (0, 1)), rotate: 90deg)
    beam-splitter("bs", (rel: (0, 1)), flip: true)

    lens("l1", (to: "bs", rel: (1, 0)))
    detector("d1", (rel: (1, 0)))

    mirror("m1", (to: "bs.south", rel: (0, 1)), rotate: 225deg)
    lens("l2", (rel: (-1, 0)))
    detector("d2", (rel: (-1, 0)), rotate: 180deg)

    cetz.draw.content("d1.north", [APD], anchor: "west")
    cetz.draw.content("d2.north", [APD], anchor: "east")
    cetz.draw.content("ph.north", [pinhole], anchor: "south")

    beam("", "in", "bs", "d1", mark: (end: ">>", stroke: (dash: "solid")))
    beam("", "bs.default", "m1", "d2", mark: (end: ">>", stroke: (dash: "solid")))
}

#test({
    set-style(content: (padding: 0.1), beam: (stroke: (thickness: 1pt, paint: black, dash: "loosely-dotted")))
    import cetz.draw: group, on-layer, move-to, anchor, set-origin, content, scope, rotate
    rotate(-90deg)

    group(name: "laser", {
        beam-splitter("bs", (0, 0))
        mirror("m1", (rel: (0, 2)), rotate: 225deg)
        laser("solea", (rel: (-2.5, 0)))


        move-to("bs.center")
        mirror("m2", (rel: (-3, 0)), rotate: -45deg)
        laser("532nm", (rel: (0, -1.5)), rotate: 90deg)

        anchor("out", (to: "bs.east", rel: (2, 0)))
        filter-rot("filter", "bs.east", "out")

        beam("", "solea", "m1", "bs", "out")
        beam("", "532nm", "m2", "bs.default")

        content("filter.center", align(right)[variable\ ND filter], anchor: "east", padding: 0.5)
        content("solea.north", [laser\ (white)], anchor: "west")
        content("532nm.south", [laser (532nm)], anchor: "north")
    })
    // rect-around("laser", padding: .2, stroke: (dash: "dotted"))
    // content("laser.south-east", [laser coupling], anchor: "east")

    group(name: "sample", {
        set-origin("laser.out")
        anchor("in", (0, 0))
        mirror("m1", "in", (0, 0), (rel: (0, 4)))

        beam-splitter("bs", "m1.dst", flip: true)
        mirror("m2", (rel: (2, 0)), rotate: 135deg)
        objective("obj", (rel: (0, 1.5)), rotate: 90deg)
        sample("sample", (rel: (0, 1)), rotate: 90deg)

        mirror("m3", (to: "bs", rel: (-3, 0)), rotate: 45deg)
        move-to((rel: (0, .5)))
        for i in range(1, 6) {
            flip-filter("f" + str(i), (rel: (0, .3)), rotate: 90deg)
        }

        anchor("out", (to: "m3", rel: (0, 3.1)))

        beam("", "in", "m1", "bs", "m2", "sample")
        beam("", "bs.default", "m3", "out")

        set-style(content: (padding: 0.1))
        content("bs.south", [10:90 beam\ splitter], anchor: "west")
        content("f3.north", align(center)[optional\ filters], anchor: "south")
        content("sample.east", [sample], anchor: "south", angle: -90deg)
        content("obj.south", [objective], anchor: "north")
    })
    // rect-around("sample", padding: .2, stroke: (dash: "dotted"))
    // content("sample.south-east", [light collection], anchor: "east")

    group(name: "detection", {
        set-origin("sample.out")
        light-detection()
    })
    cetz.draw.rect-around("detection", padding: (top: 0.2, left: 0.2, right: 0.2), name: "bbox", stroke: (dash: "densely-dashed"))
    content("bbox.west", [beam path diversion], anchor: "south")

    group(name: "counting", {
        set-origin("detection.out")
        photon-counting()
    })

    scope({
        set-style(beam: (stroke: (paint: orange, thickness: 14pt, dash: "solid")))
        beam("", "laser.solea", "laser.m1", "laser.bs", "sample.m1", "sample.bs", "sample.m2", "sample.obj")
        focus("", "sample.obj.east", "sample.sample.east")
        beam("", "sample.bs.default", "sample.m3", "counting.m1", "counting.l2")
        beam("", "counting.bs.default", "counting.l1")
        focus("", "counting.l2", "counting.d2")
        focus("", "counting.l1", "counting.d1")
    })

    group(name: "legend", {
        set-origin((3.3, 13.9))
        mirror("", (-.1, 0))
        content(".north", [mirror], anchor: "west")
        flip-mirror("", (.5, 0))
        content(".north", [flip mirror], anchor: "west")
        lens("", (1, 0))
        content(".north", [focal lens], anchor: "west")
        beam-splitter("", (2, 0))
        content(".north", [50:50 beam\ splitter], anchor: "west")
    })
    cetz.draw.rect-around("legend", padding: 0.2)
})

#test({
    cetz.draw.rotate(-90deg)
    set-style(beam: (stroke: (thickness: 1pt, paint: black, dash: "loosely-dotted")), content: (padding: 0.1))
    light-detection()
    
    set-style(beam: (stroke: (thickness: 15pt, paint: orange, dash: "solid")))
    fade("", "in", (to: "m1", rel: (0, -14pt/2)), flip: true)
    beam("", ".east", "m1", "m6", "cam")
})

#test({
    cetz.draw.rotate(-90deg)
    set-style(beam: (stroke: (thickness: 1pt, paint: black, dash: "loosely-dotted")), content: (padding: 0.1))
    light-detection()
    
    set-style(beam: (stroke: (thickness: 15pt, paint: orange, dash: "solid")))
    fade("", "in", (to: "m1", rel: (0, -14pt/2)), flip: true)
    beam("", ".east", "m1", "m2", "m3", "m4", "m5")
    focus("", "m5", "cam")
})

#test({
    cetz.draw.rotate(-90deg)
    set-style(beam: (stroke: (thickness: 1pt, paint: black, dash: "loosely-dotted")), content: (padding: 0.1))
    light-detection()
    
    set-style(beam: (stroke: (thickness: 15pt, paint: orange, dash: "solid")))
    fade("", "in", (to: "m1", rel: (0, -14pt/2)), flip: true)
    beam("", ".east", "m7", "prism", "m8", "m5")
    focus("", "m5", "cam")
})

#test({
    // cetz.draw.rotate(-90deg)
    // set-style(beam: (stroke: (thickness: 1pt, paint: black, dash: "loosely-dotted")), content: (padding: 0.1))
    // light-detection()


    // cetz.draw.set-origin("out")
    // photon-counting()

    // set-style(beam: (stroke: (thickness: 15pt, paint: orange, dash: "solid")))
    // fade("", "inin", (to: "m1", rel: (0, -14pt/2)), flip: true)
    // beam("", ".east", "m7", (rel: (0, .5)))
    // fade("", (), "out")
})
