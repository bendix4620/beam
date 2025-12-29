#import "dependencies.typ": cetz
#import "decorations.typ": current, flow, voltage
#import "utils.typ": expand-stroke, get-label-anchor, get-style, opposite-anchor, resolve, resolve-style
#import cetz.styles: merge
#import cetz.util: merge-dictionary

#let combine-styles(uid, cetz-style, beam-style, user-style) = {
    let beam-style = beam-style
    let user-style = user-style
    let user-stroke = user-style.remove("stroke", default: (:))

    // Resolve style: cetz-style < beam-style < user-style
    let style = merge(cetz-style.at(uid, default: (:)), beam-style.at(uid, default: (:)))
    style = merge(style, user-style)

    // Override stroke by user stroke
    style = merge(expand-stroke(style), (stroke: user-stroke))
    return style
}

#let component(
    draw: none,
    label: none,
    axis: false,
    scale: 1.0,
    rotate: 0deg,
    position: 50%,
    debug: none,
    num-nodes: (1, 2),
    ..params,
) = {
    let (uid, name, ..nodes) = params.pos()
    assert(nodes.len() in num-nodes, message: "needs exactly " + num-nodes.map(str).join(", ", last: " or ") + " nodes")
    assert(nodes.at(1, default: none) == none or rotate == 0deg, message: "can only use rotate argument with 1 node")
    assert(type(name) == str, message: "component name must be a string")
    assert(type(scale) == float or (type(scale) == dictionary), message: "scale must be a dictionary or a float")
    assert(type(rotate) == angle, message: "rotate must an angle")
    assert(label == none or type(label) in (content, str, dictionary), message: "label must be content, dictionary or string")

    let p-rotate = rotate
    let p-scale = scale
    let p-draw = draw
    import cetz.draw: *

    group(name: name, ctx => {
        // Save the current style
        let keep-style = ctx.style
        let orig-transform = ctx.transform
        cetz.draw.set-style(..cetz.styles.default)

        let beam-style = get-style(ctx)
        let style = combine-styles(uid, keep-style, beam-style, params.named())

        let p-rotate = p-rotate
        let (ctx, ..nodes) = cetz.coordinate.resolve(ctx, ..nodes)
        let p-origin = nodes.first()
        if nodes.len() == 2 {
            p-rotate = cetz.vector.angle2(..nodes)
            p-origin = (nodes.first(), position, nodes.last())
        } else if nodes.len() == 3 {
            let (src, c, dst) = nodes
            p-rotate = {
                // no idea why, but this fixes wrong rotations
                let a1 = cetz.vector.angle2(src, c)
                let a2 = cetz.vector.angle2(c, dst)
                (a1 + a2) / 2 + 180deg * 1 * int(a1 > a2) + 90deg
            }
            p-origin = c
        }
        anchor("src", nodes.first())
        anchor("dst", nodes.last())
        anchor("default", p-origin)
        set-origin(p-origin)
        rotate(p-rotate)

        // Component
        on-layer(1, {
            group(name: "component", {
                // Scaling
                let style-scale = style.at("scale", default: (x: 1.0, y: 1.0))
                if type(style-scale) == float {
                    style-scale = (x: style-scale, y: style-scale)
                }

                if (type(p-scale) == float) {
                    scale(x: p-scale * style-scale.x, y: p-scale * style-scale.y)
                } else {
                    scale(x: p-scale.at("x", default: 1.0) * style-scale.x, y: p-scale.at("y", default: 1.0) * style-scale.y)
                }
                if axis {
                    let style-axis = merge(beam-style.axis, resolve(style.at("axis", default: (:))))
                    let length = style-axis.remove("length", default: 1)
                    on-layer(2, line((-length / 2, 0), (length / 2, 0), ..style-axis))
                }
                // keep passed points transformation invariant
                get-ctx(ctx => {
                    let t = cetz.matrix.mul-mat(
                        cetz.matrix.inverse(ctx.transform),
                        orig-transform,
                    )
                    let nodes = nodes.map(it => cetz.util.apply-transform(t, it))
                    draw(ctx, nodes, style)
                })

                // TODO: figure out reasonable bounds for 3-point components
                copy-anchors("bounds")
            })
        })

        copy-anchors("component")

        // Label
        on-layer(0, {
            if label != none {
                let label-style = merge(beam-style.label, style.at("label", default: (:)))
                label-style = merge(label-style, if type(label) == dictionary { label } else { (content: label) })

                let anchor = get-label-anchor(p-rotate)
                let resolved-anchor = if type(label-style.anchor) == str and "south" in label-style.anchor { opposite-anchor(anchor) } else { anchor }
                content(
                    if type(label-style.anchor) == str { "component." + label-style.anchor } else { label-style.anchor },
                    anchor: label-style.at("align", default: resolved-anchor),
                    label-style.content,
                    padding: label-style.distance,
                )
            }
        })

        // Bringing back the current style
        cetz.draw.set-style(..keep-style)
    })

    // Show symbol anchors in debug mode
    cetz.draw.get-ctx(ctx => {
        let debug = if debug == none { get-style(ctx).debug.enabled } else { debug }
        if (debug) {
            on-layer(1, ctx => {
                let style = ctx.beam.style.debug
                for-each-anchor(name, exclude: ("start", "end", "mid", "component", "line", "bounds", "gl", "0", "1", "default"), name => {
                    circle((), radius: style.radius, stroke: style.stroke)
                    content((rel: (0, style.shift)), box(inset: style.inset, text(style.font, name, fill: style.fill)), angle: style.angle)
                })
            })
        }
    })
    move-to(name)
}

// TODO: update this to more modern and resilient function (with "wirein" and "wireout" anchors)
#let interface(node1, node2, ..params, io: false) = {
    import cetz.draw: *

    hide(rect(node1, node2, name: "bounds"))
    if io {
        let (node3, node4) = (0, 0)
        if params.pos().len() == 2 {
            (node3, node4) = params.pos()
        } else {
            (node3, node4) = ("bounds.west", "bounds.east")
        }
        anchor("src", node3)
        anchor("dst", node4)
    }
}
