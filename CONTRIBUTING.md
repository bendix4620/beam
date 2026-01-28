I very much welcome feedback and contributions of any kind. Simply open an [issue](https://github.com/bendix4620/beam/issues) or a [PR](https://github.com/bendix4620/beam/pulls) to get in touch. Currently pressing tasks are
- more (aesthetic) components
- expand documentation/add examples
- discover bugs.


## Documentation
Automatically generate the manual with [tidy](https://typst.app/universe/package/tidy/).
```shell
typst compile --root . docs/main.typ manual.pdf
```
## Tests
Run tests locally with [tytanic](https://github.com/typst-community/tytanic)
```shell
tt run --no-fail-fast
```

## Format
Format code with [typstyle](https://github.com/typstyle-rs/typstyle)
```shell
typstyle -l 120 -t 4 -i src
```
