#import "/src/component.typ": component, interface
#import "/src/dependencies.typ": cetz
#import cetz.draw: *

#let sample(name, ..params) = {
    let draw(ctx, position, style) = {
        interface((-style.width / 2, -style.height / 2), (style.width / 2, style.height / 2), io: position.len() < 2)

        rect("bounds.north-west", "bounds.south-east", ..style)
    }
    component("sample", name, draw: draw, ..params)
}
