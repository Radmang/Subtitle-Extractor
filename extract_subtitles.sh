#!/bin/bash

# Loop until the user chooses to exit
while true; do
    # Clear the console
    clear

    # Prompt the user to enter the directory path
    read -p "Enter the directory path (or type 'q' to quit): " directory

    # Check if the user wants to exit
    if [[ "$directory" == "q" ]]; then
        break
    fi

    # List of video file extensions to process
    extensions=".mp4 .avi .mkv"

    # Iterate over each video file with the specified extensions in the directory
    for file in "$directory"/*; do
        # Check if the file is a regular file
        if [[ -f "$file" ]]; then
            # Check if the file extension is in the allowed list
            ext="${file##*.}"
            if [[ " $extensions " == *" $ext "* ]]; then
                # Extract the filename without the extension
                filename="${file%.*}"

                # Run FFmpeg command to extract subtitles and convert to SRT format
                ffmpeg -i "$file" -map 0:s:0 -c:s srt "$directory/$filename.srt"
            fi
        fi
    done
done
