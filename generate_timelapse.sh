#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <destination_folder> <filename>"
    exit 1
fi

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "Error: ffmpeg is not installed. Please install ffmpeg to use this script."
    exit 1
fi

# Destination folder
dest_folder="$1"

# Filename
filename="$2"

# Check if the destination folder exists
if [ ! -d "$dest_folder" ]; then
    echo "Error: Destination folder does not exist."
    exit 1
fi

# Check if the file exists
if [ ! -f "$filename" ]; then
    echo "Error: File does not exist."
    exit 1
fi

# Extract the filename without the path
base_filename=$(basename "$filename")

# Create a temporary directory to store the extracted frames
temp_dir=$(mktemp -d)

# Extract frames from the input video at a rate of 1 frame per second and save them as PNG images in the temporary directory
# adjust frames per second as needed
ffmpeg -i "$filename" -r 1 -f image2 "$temp_dir/%05d.png"

# Create the timelapse video from the extracted frames and output it to the destination folder
ffmpeg -i "$temp_dir/%05d.png" -crf 18 "${dest_folder}/${base_filename}_timelapse.mp4"

# Remove the temporary directory and its contents
rm -rf "$temp_dir"

echo "Timelapse video generated: ${dest_folder}/${base_filename}_timelapse.mp4"
