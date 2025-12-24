#import "/src/component.typ": component, interface
#import "/src/dependencies.typ": cetz
#import cetz.draw: *

#let prism(name, ..params) = {
  let draw(ctx, position, style) = {
    assert(position.len() in (1, 3), message: "Prisms only work with 1 or 3 points")

    translate(x: 0.45*style.radius)
    let x = style.radius*calc.sin(30deg)
    let y = style.radius*calc.cos(30deg)
    interface((x, y), (-style.radius, -y))

    polygon((0, 0), 3, angle: 180deg, ..style)
  }
  component("prism", name, draw: draw, ..params)
}
