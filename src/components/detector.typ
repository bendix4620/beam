#import "/src/component.typ": component, interface
#import "/src/dependencies.typ": cetz
#import cetz.draw: *

#let detector(name, ..params, position: 100%) = {
    let draw(ctx, position, style) = {
        interface((0, -style.radius), (style.radius, style.radius), io: true)

        arc((0, style.radius), start: 90deg, stop: -90deg, ..style)
    }
    component("detector", name, draw: draw, ..params, position: position)
}
