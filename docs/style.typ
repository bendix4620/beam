#import "@preview/tidy:0.4.3"
#import tidy.styles.default: *

#let show-example(
    ..args,
) = {
    set block(breakable: false)
    let preview-block(..args, body) = {
        show selector.or(box, block): set align(center + horizon)
        block(radius: 3pt, fill: rgb("#e4e5ea"), ..args, body)
    }
    example.show-example(
        ..args,
        layout: tidy.show-example.default-layout-example.with(
            scale-preview: 100%,
            code-block: block.with(radius: 3pt, stroke: .5pt + luma(200)),
            preview-block: preview-block,
            col-spacing: 5pt,
        ),
    )
}
