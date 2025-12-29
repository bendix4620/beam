#import "/src/component.typ": component, interface
#import "/src/dependencies.typ": cetz
#import cetz.draw: *

#let filter(name, ..params) = {
    let draw(ctx, position, style) = {
        interface((-style.width / 2, -style.height / 2), (style.width / 2, style.height / 2), io: position.len() < 2)

        rect("bounds.north-west", "bounds.south-east", ..style)
    }
    component("filter", name, draw: draw, ..params)
}

#let flip-filter = filter.with(stroke: (dash: "densely-dashed"))

#let filter-rot(name, ..params) = {
    let draw(ctx, position, style) = {
        interface((-style.width / 2, -style.height / 2), (style.width / 2, style.height / 2), io: true)

        translate(y: style.height / 6)
        rect((-style.width / 2, -style.width / 2), (style.width / 2, style.width / 2), ..style)
        line((0, -style.height / 3), (0, style.height / 3))
    }
    component("filter-rot", name, draw: draw, ..params)
}
