#import "@preview/tidy:0.4.3"
#import "style.typ"
#import "template.typ": *
#import "/src/lib.typ" as beam

#show raw.where(block: false, lang: "type"): it => {
    let type = it.text
    if "()" in type {
        return it
    }
    h(2pt)
    let clr = tidy.styles.default.colors.at(type, default: tidy.styles.default.default-type-color)
    box(outset: 2pt, fill: clr, radius: 2pt, it)
    h(2pt)
}

#show: project.with(
    title: "beam",
    subtitle: "draw optics experiment setups with CeTZ",
    url: "https://github.com/bendix4620/beam",
    date: datetime.today().display(),
    version: "0.1.0",
    abstract: [In a landscape dominated by copy pasting inkscape templates beam aims to simplify the creation of schematics for experiment setups in the field of optics.],
)
#set heading(numbering: "1.1")
#show heading: it => {
    if it.level > 3 {
        return it.body
    }
    it
}

#let load-example(file) = {
    let preamble = "<<<#import \"@preview/beam:0.1.0\"\n"
    let code = read(file)
    raw(preamble + code.split("\n").slice(2).join("\n"))
}

#let cetz = link("https://github.com/cetz-package/cetz", [CeTZ])
#let zap = link("https://github.com/l0uisgrange/zap", [zap]) + emoji.lightning

= Getting Started
beam is heavily inspired by #zap. The usage should feel very familiar to those accustomed to it.

#style.show-example(
    scope: (beam: beam),
    load-example("/examples/quickstart.typ"),
)

All components accept 1-3 coordinates#footnote[except #ref-fn(prefix: "components-", "beam()"), it takes $>=2$ coordinates]. The coordinates can be anything that #cetz can parse and are used to position the components automatically

/ 1 coordinate: places the component at the given point. It can be rotated by passing `rotate: <angle>` to the component's function.
/ 2 coordinates: alignes the component between the given points. The position can be adjusted by passing `position: <ratio>` to the component#footnote[For some components this value is always fixed].
/ 3 coordinates: alignes the component to mimic reflection/refraction. It is placed at the middle point and is rotated to face the bisector of the angle spanned by the 3 points.

Please note that there is no standard for depicting optical components, so I gathered all the inspiration from colleagues, friends and certain #link("https://www.gwoptics.org/ComponentLibrary/", [Inkscape template]) and simply drew some symbols.

#pagebreak()
= Styling
Styling works just like in #cetz. However, beam uses a dedicated function for styling to not interfere with other #cetz;-based libraries.

Styling can be applied globally or locally on any given component.
#style.show-example(
    scope: (beam: beam),
    load-example("/examples/styling.typ"),
)

#pagebreak()
= Components
#show raw.where(block: true): set block(breakable: false)
All components follow the same interface. Below is a list of the available optical components. Parameters without dedicated description are passed to #ref-fn("component()").

#set raw(lang: "type")
#let component-docs = tidy.parse-module(
    (
        read("/src/components/beam.typ"),
        read("/src/components/detector.typ"),
        read("/src/components/filter.typ"),
        read("/src/components/laser.typ"),
        read("/src/components/lens.typ"),
        read("/src/components/mirror.typ"),
        read("/src/components/objective.typ"),
        read("/src/components/pinhole.typ"),
        read("/src/components/prism.typ"),
        read("/src/components/sample.typ"),
        read("/src/components/splitter.typ"),
    ).join("\n"),
    scope: (beam: beam),
    label-prefix: "components-",
    enable-curried-functions: false,
)

#tidy.show-module(component-docs, first-heading-level: 1, style: style)

#pagebreak()
= Custom Components
Custom components can be easily created with the help of #ref-fn("component()") and #ref-fn("interface()").
#style.show-example(
    scope: (beam: beam),
    load-example("/examples/custom.typ"),
)

#pagebreak()
= Internals
#let internal-docs = tidy.parse-module(
    (
        read("/src/component.typ"),
        read("/src/decoration.typ"),
        read("/src/styles.typ"),
        read("/src/setup.typ"),
    ).join("\n"),
    scope: (beam: beam),
    label-prefix: "internal-",
)
#tidy.show-module(internal-docs, first-heading-level: 1, style: style)
#tidy.styles.default
