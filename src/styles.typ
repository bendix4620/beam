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
            dash: "densely-dash-dotted"
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
            thickness: 10pt,
            cap: "butt",
            join: "bevel",
            paint: green,
        )
    ),
    // Components
    resistor: (
        variant: auto,
        scale: auto,
        stroke: auto,
        fill: auto,
        width: 1.41,
        height: .47,
        zigs: 3,
    ),
    mirror: (
        scale: auto,
        stroke: auto,
        fill: none,
        width: 1,
        height: .3,
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
    prism: (
        scale: auto,
        stroke: auto,
        fill: none,
        radius: .65,
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
    objective: (
        scale: auto,
        stroke: auto,
        fill: black,
        width: 1,
        height: 1,
        axis: (
            length: 2
        )
    ),
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
)
