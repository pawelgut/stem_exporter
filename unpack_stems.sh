#!/bin/bash

#
# Extracts tracks from stems files and puts them in folders
# named after the stem filenames.
#

sourceDir=~/Downloads/
targetDir=~/Music/Ableton/User\ Library/MyInstruments/Stems/

for stem in $sourceDir*.mp4
do
  if [[ $stem == *.stem.mp4 ]]
  then
    name=$(basename $stem)
    name=${name%\.*}
    dirName=$targetDir"$name"  
    if [ ! -d "$dirName" ]; then
      echo "Extracting $name..."
      echo $dirName

      # Create a directory
      dirName=$targetDir"$name"
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
    else
      echo "Already extracted $name"
    fi
  fi

done

