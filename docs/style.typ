#import "dependencies.typ": tidy
#import tidy.styles: default
#import default: *

#let show-example(
    ..args,
) = {
    set block(breakable: false)
    // set block(stroke: red)
    // set block(inset: (left: -5pt))

    let layout(code, preview, dir: ltr, ..sink) = {
        let preview = align(center + horizon, pad(5pt, preview))
        let code = pad(.65em, code)

        let columns = (66.67%, 33.33%)
        let stroke = luma(220)
        let grid-stroke = (right: stroke)

        if dir.axis() == "vertical" {
            columns = (100%,)
            grid-stroke = (bottom: stroke)
        }
        if dir.sign() < 0 {
            (preview, code) = (code, preview)
            columns = columns.rev()
        }
        block(
            width: 100%,
            stroke: stroke,
            radius: 5pt,
            grid(
                columns: columns,
                stroke: (x, y) => if x + y == 0 { grid-stroke },
                code, preview,
            ),
        )
    }

    // set block(stroke: red)
    default.example.show-example(..args, layout: layout)
}

#let show-type = default.show-type.with(
    style-args: (colors: default.colors),
)

// Create a parameter description block, containing name, type, description and optionally the default value.
#let show-parameter-block(
    function-name: none,
    name,
    types,
    content,
    style-args,
    show-default: false,
    default: none,
) = block(
    inset: (left: 10pt),
    // fill: rgb("eee"),
    radius: 5pt,
    width: 100%,
    breakable: true,
    [
        #block(sticky: true)[
            #box(heading(level: style-args.first-heading-level + 3, name))
            #if function-name != none and style-args.enable-cross-references {
                label(function-name + "." + name.trim("."))
            }
            #h(1.2em)
            #types.map(x => (style-args.style.show-type)(x, style-args: style-args)).join([ #text("or", size: .6em) ])
            #h(1fr)
            #if show-default [
                #raw(lang: none, "default:") #raw(lang: "typc", default)
            ]
        ]
        // #h(2cm)

        #block(
            stroke: (left: luma(200)),
            inset: 10pt,
            outset: -5pt,
            above: .3em,
            breakable: true,
            content,
        )
    ],
)

#let show-parameter-list(fn, style-args: (:)) = {
    pad(x: 10pt, {
        set text(font: "DejaVu Sans Mono", size: 0.85em, weight: 340)
        text(fn.name, fill: style-args.colors.at("signature-func-name", default: rgb("#4b69c6")))
        "("
        let inline-args = fn.args.len() < 2
        if not inline-args { "\n  " }
        let items = ()
        let args = fn.args
        for (name, info) in fn.args {
            if style-args.omit-private-parameters and name.starts-with("_") {
                continue
            }
            let types
            if "types" in info {
                types = ": " + info.types.map(x => show-type(x, style-args: style-args)).join(" ")
            }
            if (
                style-args.enable-cross-references
                    and not (info.at("description", default: "") == "" and style-args.omit-empty-param-descriptions)
            ) {
                name = link(label(style-args.label-prefix + fn.name + "." + name.trim(".")), name)
            }
            let default = if "default" in info and info.description == "" {
                [ #raw(lang: "typc", "= " + info.default)]
            }
            items.push(name + types + default)
        }
        items.join(if inline-args { ", " } else { ",\n  " })
        if not inline-args { "\n" } + ")"
        if "return-types" in fn and fn.return-types != none {
            " -> "
            fn.return-types.map(x => show-type(x, style-args: style-args)).join(" ")
        }
    })
}
