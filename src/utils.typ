#let angle-to-anchor-bins = range(0, 360, step: 45)
#let angle-to-anchor-table = ("east", "north-east", "north", "north-west", "west", "south-west", "south", "south-east")
#let anchor-to-angle-table = angle-to-anchor-table.zip(angle-to-anchor-bins).to-dict()

#let normalize-angle(a) = {
  let x = calc.rem(a.deg(), 360)
  x + 360*int(x < 0)
}

#let anchor-to-angle(anchor) = 1deg*anchor-to-angle-table.at(anchor, default: 0)

#let angle-to-anchor(angle-deg) = {
    let normalized-angle = normalize-angle(angle-deg -22.5deg)
    let i = angle-to-anchor-bins.position(it => normalized-angle < it)
    if i == none {
      return angle-to-anchor-table.first()
    }
    angle-to-anchor-table.at(i)
}

// Gives the opposite anchor
#let opposite-anchor(anchor) = {
    if anchor == "north" {
        "south"
    } else if anchor == "south" {
        "north"
    } else if anchor == "east" {
        "west"
    } else if anchor == "west" {
        "east"
    } else if anchor == "north-east" {
        "south-west"
    } else if anchor == "north-west" {
        "south-east"
    } else if anchor == "south-east" {
        "north-west"
    } else if anchor == "south-west" {
        "north-east"
    } else if anchor == "center" {
        "center"
    } else {
        panic("anchor not recognized: " + anchor)
    }
}

#let stroke-to-dict(style) = {
    let style = if style == none { stroke(0pt) } else { stroke(style) }
    let raw-dict = (
        thickness: style.thickness,
        paint: style.paint,
        join: style.join,
        cap: style.cap,
        miter-limit: style.miter-limit,
        dash: style.dash,
    )
    let dict = (:)
    for (k, v) in raw-dict {
        if v != auto {
            dict.insert(k, v)
        }
    }
    return dict
}

#import "/src/dependencies.typ": cetz

#let resolve(dict) = {
    // Special dictionaries
    let hold = ("stroke", "scale", "position", "axis", "beam")

    let resolve-recursive(dict, defs) = {
        let dict-defs = (:)
        for (k, v) in dict {
            if type(v) != dictionary {
                if v == auto and k in defs.keys() {
                    dict.at(k) = defs.at(k)
                }
                dict-defs.insert(k, dict.at(k))
            } else if k in hold {
                for key in defs.at(k, default: (:)).keys() {
                    if key in v.keys() and v.at(key) == auto or key not in v.keys() {
                        dict.at(k).insert(key, defs.at(k).at(key))
                    }
                }
                dict-defs.insert(k, dict.at(k))
            }
        }
        for (k, v) in dict {
            if type(v) == dictionary and k not in hold {
                dict.at(k) = resolve-recursive(dict.at(k), defs + dict-defs)
            }
        }
        return dict
    }
    return resolve-recursive(dict, (:))
}

#let expand-stroke(dict) = {
    let expand-stroke-recursive(dict) = {
        for (k, v) in dict {
            if type(v) == dictionary {
                dict.at(k) = expand-stroke-recursive(dict.at(k))
            } else if k == "stroke" and v != auto {
                dict.at(k) = stroke-to-dict(v)
            }
        }
        return dict
    }
    return expand-stroke-recursive(dict)
}

#let set-style(..style) = {
    cetz.draw.set-ctx(ctx => {
        let new-style = style.named()
        for key in new-style.keys() {
            let style-dict = ((key): (new-style.at(key)))
            if ctx.beam.style.at(key, default: (:)) == (:) {
                ctx.style = cetz.styles.merge(ctx.style, style-dict)
            } else {
                ctx.beam.style = cetz.styles.merge(ctx.beam.style, expand-stroke(style-dict))
            }
        }
        return ctx
    })
}

#let resolve-style(style) = {
    if style.stroke.paint == auto {
        style.stroke.paint = style.foreground
    }
    if style.background == auto {
        style.background = ctx.background
    }
    if style.fill == auto {
        style.fill = style.background
    }
    return resolve(style)
}

#let get-style(ctx) = {
    return resolve-style(ctx.beam.style)
}
