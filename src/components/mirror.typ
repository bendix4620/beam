#import "/src/component.typ": component, interface
#import "/src/dependencies.typ": cetz
#import cetz.draw: *

#let draw(ctx, position, style) = {
    interface((-style.height, -style.width / 2), (0, style.width / 2))

    // how to handle 2-part component styles?
    rect((-style.height * .67, -style.width / 2), (0, style.width / 2), ..style)
    rect((-style.height, -style.width / 2), (-style.height * .67, style.width / 2), fill: black)
}

#let mirror(name, ..params) = {
    component("mirror", name, draw: draw, ..params, num-nodes: (1, 3))
}

#let flip-mirror = mirror.with(stroke: (dash: "densely-dashed"))

#let grating(name, ..params) = {
    component("grating", name, draw: draw, ..params, num-nodes: (1, 3))
}
