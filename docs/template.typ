#import "style.typ"

// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let project(
    title: "",
    subtitle: "",
    abstract: [],
    authors: (),
    url: none,
    date: none,
    version: none,
    body,
) = {
    // Set the document's basic properties.
    set document(author: authors, title: title)
    set page(numbering: "1", number-align: center)

    show heading.where(level: 1): it => block(smallcaps(it), below: 1em)
    // set heading(numbering: (..args) => if args.pos().len() == 1 { numbering("I", ..args) })
    set heading(numbering: "I.a")
    show list: pad.with(x: 5%)
    show heading.where(level: 3): set text(1.2em)

    // show link: set text(fill: purple.darken(30%))
    show link: it => {
        let dest = str(it.dest)
        if "." in dest and not "/" in dest { return underline(it, stroke: luma(60%), offset: 1pt) }
        set text(fill: rgb("#1e8f6f"))
        underline(it)
    }

    v(4em)

    // Title row.
    align(center)[
        #block(text(weight: 700, 1.75em, title))
        #block(text(1.0em, subtitle))
        #v(4em, weak: true)
        v#version #h(1.2cm) #date
        #block(link(url))
        #v(1.5em, weak: true)
    ]

    // Author information.
    pad(
        top: 0.5em,
        x: 2em,
        grid(
            columns: (1fr,) * calc.min(3, authors.len()),
            gutter: 1em,
            ..authors.map(author => align(center, strong(author))),
        ),
    )

    v(3cm, weak: true)

    // Abstract.
    pad(
        x: 3.8em,
        top: 1em,
        bottom: 1.1em,
        align(center)[
            #heading(
                outlined: false,
                numbering: none,
                text(0.85em, smallcaps[Abstract]),
            )
            #abstract
        ],
    )

    // Main body.
    set par(justify: true)
    v(1fr)
    let toc = outline(title: none, depth: 2)
    align(center, heading(outlined: false, numbering: none, [Table of Contents]))
    context block(
        height: measure(toc).height / 2 + .65em,
        columns(2, toc),
    )
    v(1fr)
    pagebreak(weak: true)

    // configure code/examples
    set raw(lang: "notnone")
    show raw.where(block: true): set text(size: .95em)
    show raw.where(block: true): set block(breakable: false)
    show raw.where(lang: "notnone"): it => box(
        inset: (x: 3pt),
        outset: (y: 3pt),
        radius: 40%,
        fill: luma(235),
        it,
    )

    // shorthand for typ highlighitng
    show regex("type:(\w+)"): it => style.show-type(it.text.trim("type:", at: start, repeat: false))

    // only number headings down to the function level, no numbering on parameters
    set heading(numbering: "1.1.a.1")
    show heading: it => {
        if it.level > 3 {
            return it.body
        }
        it
    }
    body
}

#let ref-fn(name, prefix: "internal-") = link(label(prefix + name), raw(lang: none, name))
