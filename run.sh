#!/usr/bin/env sh

find ./input -type f | while IFS= read -r file; do 
    if file "$file" |grep -qE 'image|bitmap'; then
        echo "trimming: $file"
        mkdir -p $(dirname "${file/\/input\//\/output\/}")
        convert -trim "$file" "${file/\/input\//\/output\/}"; 
    fi
done

image_optim -r ./output