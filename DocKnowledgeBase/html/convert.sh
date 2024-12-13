#!/bin/bash

# Check if libreoffice is installed
if ! command -v libreoffice &> /dev/null; then
  echo "Error: LibreOffice is not installed. Please install it (e.g., sudo apt-get install libreoffice)."
  exit 1
fi

# Find all .odt files in the current directory
find . -maxdepth 1 -name "*.odt" -print0 | while IFS= read -r -d $'\0' file; do
  # Extract the filename without extension
  filename=$(basename "$file" .odt)

  # Construct the output HTML filename
  output_file="$filename.html"

  # Convert the ODT to HTML using LibreOffice in headless mode
  libreoffice --headless --convert-to html --outdir . "$file"

  # Check if the conversion was successful
  if [ -f "$output_file" ]; then
    echo "Converted: $file -> $output_file"
  else
    echo "Error converting: $file"
  fi
done