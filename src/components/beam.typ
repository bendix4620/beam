#import "/src/component.typ": component, interface, combine-styles
#import "/src/utils.typ": get-style
#import "/src/dependencies.typ": cetz
#import cetz.draw: *

#let beam(name, ..params) = {
  group(ctx => {
    let keep-style = ctx.style
    let style = combine-styles("beam", keep-style, get-style(ctx), params.named())
    line(..params.pos(), ..style, name: name)
  })
}
