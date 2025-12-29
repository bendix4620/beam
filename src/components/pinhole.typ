#import "/src/component.typ": component, interface
#import "/src/dependencies.typ": cetz
#import cetz.draw: *

#let pinhole(name, ..params) = {
    let draw(ctx, position, style) = {
        interface((-style.width / 2, -style.height / 2), (style.width / 2, style.height / 2), io: position.len() < 2)
        let inlet = style.height / 7

        for sign in (+1, -1) {
            rect(
                (-style.width / 2, sign * style.height / 2),
                (style.width / 2, sign * inlet),
                ..style,
            )
            rect(
                (-style.width / 6, sign * style.gap / 2),
                (style.width / 6, sign * inlet),
                ..style,
            )
        }
    }
    component("pinhole", name, draw: draw, ..params)
}
