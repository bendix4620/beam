#import "/src/component.typ": component, interface
#import "/src/dependencies.typ": cetz
#import cetz.draw: *

#let mirror(name, ..params) = {
  let draw(ctx, position, style) = {
    assert(position.len() == 3, message: "Mirrors and gratings need 3 points")

    interface((-style.height, -style.width/2), (0, style.width/2))

    // how to handle 2-part component styles?
    rect((-style.height*.67, -style.width/2), (0, style.width/2), ..style)
    rect((-style.height, -style.width/2), (-style.height*.67, style.width/2), fill: black)
  }
  component("mirror", name, draw: draw, ..params)
}

#let flip-mirror = mirror.with(stroke: (dash: "densely-dashed"))

#let grating = mirror.with(fill: tiling(size: (2pt, 5pt), {
  set std.line(stroke: .5pt)
  place(std.line(start: (0%, 100%), end: (100%, 0%)))
  place(std.line(start: (50%, 150%), end: (150%, 50%)))
  place(std.line(start: (-50%, 50%), end: (50%, -50%)))
}))
