#!/bin/bash

#
# Extracts tracks from stems files and puts them in folders
# named after the stem filenames.
#

for stem in *.mp4
do
  name=${stem%\.*}
  echo $name

  # Create a directory
  dirName=~/Music/Ableton/User\ Library/MyInstuments/Stems/"$name"
  rm -R "$dirName"
  mkdir "$dirName"

  # # Album cover
  coverFilename="$dirName"/"$name"_cover.jpg
  echo "  - Extracting album cover to $coverFilename"
  ffmpeg -i "$stem" -an -vcodec copy "$coverFilename"

  # Audio tracks
  for trackNo in 1 2 3 4 5 6 7
  do
    trackFilename="$dirName"/"$name"_"$trackNo".wav
    echo "  - Extracting audio track $trackNo to $trackFilename"
    ffmpeg -i $stem -map 0:$trackNo -vn "$trackFilename"
  done
done