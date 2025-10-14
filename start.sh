#!/bin/bash

# Arrays to store filenames
declare -a files
declare -a flv_files

while IFS= read -r file || [ -n "$file" ]; do
  files+=("$file")
done < /playlist.txt

echo "Found ${#files[@]} files in playlist."

# Preprocess all videos
for file in "${files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "File $file not found, skipping..."
    continue
  fi

  flv="${file%.*}.flv"
  if [ -f "$flv" ]; then
    echo "$flv already exists, skipping conversion."
    flv_files+=("$flv")
    continue
  fi

  echo "Processing file: $file"

  # Compute FPS and -g 
  fps=$(ffprobe -v 0 -of csv=p=0 -select_streams v:0 -show_entries stream=avg_frame_rate "$file")
  fps=$(echo "$fps" | awk -F/ '{printf "%.2f", $1/$2}')
  g=$(printf "%.0f" $(echo "$fps * 2" | bc -l))
  echo "Detected FPS: $fps, setting -g to $g"

  echo "Converting $file -> $flv (g=$g)"
  ffmpeg -y -i "$file" \
    -c:v libx264 -preset medium -b:v 3000k -maxrate 3000k -bufsize 6000k \
    -vf "scale=1920:-1,format=yuv420p" \
    -g "$g" \
    -c:a aac -b:a 128k -ac 2 -ar 44100 \
    "$flv"

  flv_files+=("$flv")
done

# Create /playlist_concat.txt in ffmpeg concat format
concat_file="/playlist_concat.txt" > "$concat_file" 

for flv in "${flv_files[@]}"; do
  echo "file '/videos/$flv'" >> "$concat_file"
done

echo "FLV files:"
cat "$concat_file"

if [ -z "$STEAM_KEY" ]; then
  echo "Please set the STEAM_KEY environment variable"
  exit 1
fi

echo "Preprocessing done. Starting playlist loop..."

ffmpeg -re -f concat -stream_loop -1 -safe 0 -i /playlist_concat.txt -c copy -f flv "rtmp://ingest-rtmp.broadcast.steamcontent.com/app/$STEAM_KEY"