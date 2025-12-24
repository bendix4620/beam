#import "/src/component.typ": component, interface
#import "/src/dependencies.typ": cetz
#import cetz.draw: *

#let objective(name, ..params) = {
  let draw(ctx, position, style) = {
    interface((-style.width/2, -style.height/2), (style.width/2, style.height/2), io: position.len() < 2)

    merge-path(close: true, ..style, line(
      (-style.height/2, -style.width/2),
      (style.height*.3, -style.width/2),
      (style.height/2, -style.width*.3),
      (style.height/2, style.width*.3),
      (style.height*.3, style.width/2),
      (-style.height/2, style.width/2)
    ))
  }
  component("objective", name, draw: draw, ..params)
}
