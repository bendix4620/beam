#import "dependencies.typ": tidy
#import "template.typ": *
#import "style.typ"
#import "/src/lib.typ" as beam

#let url = "https://github.com/bendix4620/beam"
#show: project.with(
    title: "beam",
    subtitle: "draw optics experiment setups with CeTZ",
    url: url,
    date: datetime.today().display(),
    version: "0.1.0",
    abstract: [In a landscape dominated by copy pasting inkscape templates, *beam* aims to simplify the creation of schematics for experiment setups in the field of optics.],
)

#let load-example(file) = {
    let preamble = "<<<#import \"@preview/beam:0.1.0\"\n"
    let code = read(file)
    raw(preamble + code.split("\n").slice(2).join("\n"))
}

#let cetz = link("https://github.com/cetz-package/cetz", [CeTZ])
#let zap = link("https://github.com/l0uisgrange/zap", [zap]) + emoji.lightning

= About
I built this package, because I was frustrated with the available tools to draw schematics for simple optical setups. The options available to me were full-fledged simulation software, blender, and a certain #link("https://www.gwoptics.org/ComponentLibrary/", [Inkscape template]). None of these suit my preferences -- or skills.

Amazed by the simplicity of #zap, I gathered inspiration from colleagues and friends and started drawing some symbols and extended the framework on the fly.

Please get in touch with me on #link(url)[github] if you discover any bugs or have ideas for improvement!

= Getting Started
beam is heavily inspired by #zap. The usage should feel very familiar to those accustomed to it. Just copy the example below and play around with the component parameters.

#style.show-example(
    scope: (beam: beam),
    load-example("/examples/quickstart.typ"),
)
Be sure to check out the `examples` directory in the #link(url)[repository] for more inspiration.

= Styling
Styling works just like in #cetz. However, beam uses a dedicated functions for styling to not interfere with other #cetz;-based libraries:
- #ref-fn("set-beam-style()", prefix: "internal-") to change the current global style
- #ref-fn("get-beam-style()", prefix: "internal-") to get the current global style from #cetz's context

#block(sticky: true)[Style can also be configured locally on any given component.]
#style.show-example(
    scope: (beam: beam),
    load-example("/examples/styling.typ"),
)
The default style of any component can be inspected by
```typst
#cetz.styles.resolve(beam.styles.default, root: "<id>")
```

#pagebreak(weak: true)
= The Component Interface
This section describes the common interface of all components.
== Interface
#{
    let data = tidy.parse-module(read("/src/component.typ"), scope: (beam: beam))
    let func = data.functions.find(it => it.name == "component")
    let _ = func.args.remove("root", default: none)
    let _ = func.args.remove("sketch", default: none)
    let _ = func.args.remove("num-points", default: none)
    func.description = ""
    data.functions = (func,)

    set heading(outlined: false)
    show selector.or(heading.where(level: 2), heading.where(level: 3)): none
    tidy.show-module(
        data,
        style: style,
        enable-cross-references: false,
        show-outline: false,
        show-module-name: false,
        sort-functions: false,
        first-heading-level: 1,
        break-param-descriptions: false,
    )
}

== Anchors
#let list-anchors(..arr) = arr.pos().map(repr).map(raw.with(lang: "typc")).join(", ", last: " and ")
Components come with a rotating bounding box and many anchors.
#list-anchors(..beam.anchor.anchor-to-angle-table.keys(), "center") are placed at the corresponding bounding box positions and #list-anchors("o") at the component's position. #list-anchors("in", "out") are placed at the first and last given point, in case 2 or 3 point positioning is used.

#pagebreak()
#let doc-style(root) = [
    === Style
    style id: #raw(lang: "typc", repr(root))\
    default values: #v(.65em, weak: true)
    #pad(left: 15pt, {
        set par(leading: .5em)
        let style = beam.styles.default.at(root)
        for (key, val) in style {
            raw(lang: "typc", key + ": " + repr(val) + ",\n", block: false)
            // linebreak()
        }
    })
]
#let doc-points(points) = [
    === Points
    Supports #points points
]

= Components
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
    scope: (beam: beam, doc-style: doc-style, doc-points: doc-points),
    label-prefix: "components-",
    enable-curried-functions: false,
)

#tidy.show-module(
    component-docs,
    first-heading-level: 1,
    style: style,
)

#pagebreak()
= Custom Components
Custom components can be easily created with the help of #ref-fn("component()") and #ref-fn("interface()"). The example below creates a simple rectangle as a component. You can use it as a starting point to draw all the components you need.
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
        read("/src/anchor.typ"),
        read("/src/styles.typ"),
        read("/src/setup.typ"),
    ).join("\n"),
    scope: (beam: beam),
    label-prefix: "internal-",
)
#tidy.show-module(internal-docs, first-heading-level: 1, style: style, enable-cross-references: true)
