#!/bin/bash

for X in `find . -maxdepth 1 -type f -not -path "./thumbnails"`; do

  if [ ! -f "./thumbnails/${X}" ]; then
    echo "Generating thumbnail for ${X}..."
    convert -resize 400x225^ -gravity center -extent 400x225 -strip -interlace Plane -quality 85 "${X}" "./thumbnails/${X}"
  fi

  if [[ $(find ${X} -type f -size +409600c 2>/dev/null) ]]; then
    echo "Resizing ${X}..."
    convert -resize 1024 -strip -interlace Plane -quality 95 "${X}" "${X}"
  fi
done
