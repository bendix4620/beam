#import "/tests/utils.typ": test
#import "/src/lib.typ": *
#import cetz.draw: *

#let examples = (
    "cavity.typ",
    "custom.typ",
    "michelson.typ",
    "photolumi.typ",
    "quickstart.typ",
    "styling.typ",
)
#set page(margin: 4pt, width: auto, height: auto)

#for fname in examples {
    pagebreak(weak: true)
    include "/examples/" + fname
}
