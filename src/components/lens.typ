#import "/src/component.typ": component, interface
#import "/src/dependencies.typ": cetz
#import cetz.draw: *

#let lens(name, kind: "<>", ..params) = {
  assert(kind in ("<>", "<<", ">>", "><"), message: "Only lenses of kind '<>', '<<', '>>' or '><' are supported")

  let draw(ctx, position, style) = {
    assert(position.len() < 3, message: "Lenses can have a maximum of 2 points")

    interface((-style.width/2-style.extent, -style.height/2), (style.width/2+style.extent, style.height/2), io: position.len() < 2)
  
    merge-path(close: true, ..style, {
      let (offset-out, offset-in) = if kind.first() == "<" {
        (style.extent, 0)
      } else {
        (0, style.extent)
      }
      arc-through(
        (to: "bounds.north-west", rel: (offset-out, 0)), 
        (to: "bounds.west", rel: (offset-in, 0)), 
        (to: "bounds.south-west", rel: (offset-out, 0)),
      )

      let (offset-out, offset-in) = if kind.last() == ">" {
        (-style.extent, 0)
      } else {
        (0, -style.extent)
      }
      arc-through(
        (to: "bounds.south-east", rel: (offset-out, 0)),
        (to: "bounds.east", rel: (offset-in, 0)), 
        (to: "bounds.north-east", rel: (offset-out, 0)),
      )
    })
  }
  component("lens", name, draw: draw, ..params)
}
