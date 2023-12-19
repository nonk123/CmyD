#!/usr/bin/env bash

FILES=(
    mapinfo.txt
    cvarinfo.txt
    zscript.zs
    zscript/
)

OUTPUT=cmyd.pk3

rm -f "$OUTPUT"
zip -r "$OUTPUT" "${FILES[@]}"
