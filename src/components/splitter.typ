#import "/src/component.typ": component, interface
#import "/src/dependencies.typ": cetz
#import cetz.draw: *

#let beam-splitter(name, ..params, axis: false, flip: false) = {
    let draw(ctx, position, style) = {
        if position.len() == 3 {
            rotate(-45deg)
        }
        if flip {
            scale(y: -1)
        }

        interface((-style.width / 2, -style.height / 2), (style.width / 2, style.height / 2), io: position.len() < 2)

        rect("bounds.north-west", "bounds.south-east", ..style)
        line("bounds.north-west", "bounds.south-east", ..style)
        // automatic axis does not work for thick beam splitters
        if axis {
            line((radius: .5, angle: 45deg), (radius: .5, angle: 225deg), ..style.axis)
        }
    }
    component("beam-splitter", name, draw: draw, ..params)
}

#let beam-splitter-plate(name, ..params, flip: false) = {
    let draw(ctx, position, style) = {
        if position.len() == 2 {
            rotate(135deg)
        }
        if flip {
            scale(y: -1)
        }
        interface((0, -style.height / 2), (-style.width / 2, style.height / 2), io: position.len() < 2)

        rect("bounds.south-west", "bounds.north-east", ..style)
    }
    component("beam-splitter-plate", name, draw: draw, ..params)
}
