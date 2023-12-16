#!/bin/bash

for file in *.mov; do
    # Replace .mov extension with .mp4
    output=${file%.mov}.mp4

    # Command to convert the file
    ffmpeg -i "$file" -c:v copy -c:a copy "$output"
done
