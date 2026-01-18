# beam for typst

**beam** aims to simplify the creation of schematics for experiment setups in the field of optics.

```typst
#import "@preview/beam:0.1.0"

#beam.setup({
    import beam: *

    // draw your setup, for example...
    laser("laser", (0, 0))
    lens("l1", (1, 0))
    detector("cam", (2, 0))
    beam("", "laser", "l1")
    focus("", "l1", "cam")
})
```

## Examples
A Michelson interferometer and [more](./examples)

![michselson interferometer](./examples/michelson.png)


## Credits
I built this package on the foundations of the fabulous [zap](https://typst.app/universe/package/zap/).
