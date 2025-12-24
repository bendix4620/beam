#import "/src/dependencies.typ": cetz
#import "/src/styles.typ": default

#let setup(fallback, ..params) = {
    cetz.canvas(..params, {
        // Init style directory
        cetz.draw.set-ctx(ctx => {
            ctx.insert("beam", ("style": default))
            return ctx
        })
        fallback
    })
}
