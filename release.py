#!/usr/bin/env python3

from pathlib import Path
import subprocess
import zipfile


def zip_release(src, dst, include: list[str] | None = []):
    src = Path(src)
    dst = Path(dst)
    include = include

    with zipfile.ZipFile(dst, "w", zipfile.ZIP_DEFLATED) as zipf:

        def add_rec(fp: Path):
            if fp.is_file():
                zipf.write(fp, fp.relative_to(src))
                return
            for path in fp.iterdir():
                add_rec(path)

        for fp in src.iterdir():
            if str(fp.relative_to(src)) not in include:
                continue
            add_rec(fp)
        print("\nzipped:", *(info.filename for info in zipf.filelist), sep="\n")


# Example usage
if __name__ == "__main__":
    src = Path(__file__).parent
    dst = "latest.zip"
    include = ["examples", "src", "LICENSE", "manual.pdf", "README.md", "typst.toml"]

    # subprocess.run(
    #     ["tt", "run"],
    #     cwd=src,
    # ).check_returncode()
    # subprocess.run(
    #     ["typst", "compile", "--root", ".", "docs/main.typ", "manual.pdf"],
    #     cwd=src,
    # ).check_returncode()

    # print("\ncompiled manual.pdf")

    zip_release(src, dst, include=include)
