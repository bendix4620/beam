#import "/src/component.typ": combine-styles, component, interface
#import "/src/utils.typ": get-style
#import "/src/dependencies.typ": cetz
#import cetz.draw: *

#let beam(name, ..params) = {
    assert(params.pos().len() >= 2, message: "need at least 2 nodes")
    group(name: name, ctx => {
        let keep-style = ctx.style
        cetz.draw.set-style(..cetz.styles.default)

        let style = combine-styles("beam", keep-style, get-style(ctx), params.named())
        line(..params.pos(), ..style, name: "")
        copy-anchors("")
        cetz.draw.set-style(..keep-style)
    })
    move-to(name + ".end")
}

#let focus(name, ..params) = {
    let draw(ctx, position, style) = {
        let ext = style.stroke.thickness
        interface((position.first().at(0), -ext / 2), (position.last().at(0), ext / 2))
        on-layer(0, line(
            "bounds.north-west",
            "bounds.east",
            "bounds.south-west",
            fill: style.stroke.paint,
            stroke: none,
            close: true,
        ))
    }
    component("beam", name, draw: draw, ..params, num-nodes: (2,))
}

#let fade(name, ..params, flip: false) = {
    get-ctx(ctx => {
        let (ctx, ..nodes) = cetz.coordinate.resolve(ctx, ..params.pos(), update: false)
        let orig-position = cetz.util.apply-transform(ctx.transform, ..nodes)
        if flip {
            orig-position = orig-position.rev()
        }

        let draw(ctx, position, style) = {
            let extent = style.stroke.thickness
            let color = style.stroke.paint
            // gradient fill is calculated with respect to the AABB. Introduce an offset in the corner of the AABB to match the gradient to the rendered shape
            let angle = -cetz.vector.angle2(..orig-position)
            let padding = calc.abs(calc.sin(angle) * calc.cos(angle)) * extent / ctx.length
            let length = cetz.vector.dist(..position)
            let ratios = (
                0,
                padding,
                length + padding,
                length + 2 * padding,
            )
            let colors = (
                color,
                color,
                color.transparentize(100%),
                color.transparentize(100%),
            )
            let fill = gradient.linear(
                ..colors.zip(ratios.map(it => 100% * (it / ratios.last()))),
                angle: -angle, //- angle
            )

            interface((position.first().at(0), -extent / 2), (position.last().at(0), extent / 2))
            on-layer(0, rect(
                "bounds.north-west",
                "bounds.south-east",
                fill: fill,
                stroke: none,
            ))
        }
        component("beam", name, draw: draw, ..params, num-nodes: (2,))
    })
}
