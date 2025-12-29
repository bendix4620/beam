#let default = (
    variant: "iec",
    scale: (x: 1.0, y: 1.0),
    stroke: (
        thickness: .8pt,
        paint: auto,
        join: "miter",
        cap: "butt",
        miter-limit: 4,
        dash: none,
    ),
    axis: (
        stroke: (
            thickness: .5pt,
            paint: auto,
            dash: "densely-dash-dotted",
        ),
    ),
    fill: auto,
    background: white,
    foreground: black,
    label: (
        scale: auto,
        content: none,
        distance: 7pt,
        anchor: "north",
    ),
    debug: (
        stroke: (
            thickness: .2pt,
            paint: red,
        ),
        enabled: false,
        radius: .7pt,
        angle: -30deg,
        shift: 3pt,
        inset: 1pt,
        font: 3pt,
        fill: red,
    ),
    beam: (
        stroke: (
            thickness: 14pt,
            cap: "butt",
            join: "bevel",
            paint: green,
        ),
    ),
    // Components
    beam-splitter: (
        scale: auto,
        stroke: auto,
        fill: none,
        width: 1,
        height: 1,
        axis: auto,
    ),
    beam-splitter-plate: (
        scale: auto,
        stroke: auto,
        fill: none,
        width: .2,
        height: 1,
        axis: auto,
    ),
    detector: (
        scale: auto,
        stroke: auto,
        fill: black,
        radius: .5,
        axis: false,
    ),
    filter: (
        scale: auto,
        stroke: auto,
        fill: gray,
        width: .2,
        height: 1,
        axis: auto,
    ),
    filter-rot: (
        scale: auto,
        stroke: auto,
        fill: black,
        width: .1,
        height: 2,
        axis: auto,
    ),
    grating: (
        scale: auto,
        stroke: auto,
        fill: tiling(size: (2pt, 5pt), {
            set std.line(stroke: .5pt)
            box(width: 100%, height: 100%, fill: white, {
                place(std.line(start: (0%, 100%), end: (100%, 0%)))
                place(std.line(start: (50%, 150%), end: (150%, 50%)))
                place(std.line(start: (-50%, 50%), end: (50%, -50%)))
            })
        }),
        width: 1,
        height: .3,
        axis: auto,
    ),
    laser: (
        sclae: auto,
        stroke: auto,
        fill: black,
        length: 1.5,
        height: 1,
        axis: auto,
    ),
    lens: (
        sclae: auto,
        stroke: auto,
        fill: none,
        width: .1,
        height: 1,
        extent: .1,
        axis: auto,
    ),
    mirror: (
        scale: auto,
        stroke: auto,
        fill: white,
        width: 1,
        height: .3,
        axis: auto,
    ),
    objective: (
        scale: auto,
        stroke: auto,
        fill: black,
        width: 1,
        height: 1,
        axis: (
            length: 2,
        ),
    ),
    pinhole: (
        scale: auto,
        stroke: none,
        fill: black,
        width: .2,
        height: 1,
        gap: .1,
        axis: auto,
    ),
    prism: (
        scale: auto,
        stroke: auto,
        fill: none,
        radius: .65,
        axis: auto,
    ),
    sample: (
        scale: auto,
        stroke: auto,
        fill: aqua,
        width: .1,
        height: 1,
        axis: auto,
    ),
)
