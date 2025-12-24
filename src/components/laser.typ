#import "/src/component.typ": component, interface
#import "/src/dependencies.typ": cetz
#import cetz.draw: *

#let laser(name, ..params, position: 0%) = {
  let draw(ctx, position, style) = {
    interface((-style.length, -style.height/2), (0, style.height/2))

    cetz.draw.rect((-style.length, -style.height/2), (-0.1*style.length, style.height/2), ..style)
    cetz.draw.rect((-0.1*style.length, -style.height/3), (0, style.height/3), ..style)
  }
  component("laser", name, draw: draw, ..params, position: position)
}
