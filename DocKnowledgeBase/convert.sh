#!/bin/bash

# Get the directory path of the script
script_dir=$(dirname "$0")

# Change the current working directory to the script's location
cd "$script_dir"

# =================

# Check if libreoffice is installed
if ! command -v libreoffice &> /dev/null; then
  echo "Error: LibreOffice is not installed. Please install it (e.g., sudo apt-get install libreoffice)."
  exit 1
fi

# Function to set the HTML title
set_html_title() {
  local html_file="$1"
  local title="$2"

  # Use sed to insert the title within the <title> tags
  sed -i "s/<title>.*<\/title>/<title>$title<\/title>/g" "$html_file" || {
    echo "Warning: Could not set title in $html_file. The file might not contain <title> tags or sed encountered an error. Trying a more robust method."

    # Robust fallback using xmllint and xpath (requires libxml2-utils)
    if command -v xmllint &> /dev/null; then
      xmllint --html --xpath '//title' "$html_file" 2>/dev/null | grep -q '<title>'
      if [ $? -eq 0 ]; then
          xmllint --html --xpath '//title/text()' "$html_file" 2>/dev/null | sed -i "s/.*/<title>$title<\/title>/g" "$html_file"[1]
      else
          echo "Warning: No <title> tag found. Inserting one."
          sed -i '/<head>/a <title>'$title'</title>' "$html_file"
      fi
    else
      echo "Error: xmllint is not installed. Try installing libxml2-utils"
    fi
  }
}

# Find all .odt files in the "html" directory
find html -name "*.odt" -print0 | while IFS= read -r -d $'\0' file; do
  # Extract the filename without extension
  filename=$(basename "$file" .odt)

  # Construct the output HTML filename
  output_file="${file%.odt}.html" # Replace .odt with .html in the same directory

  # Convert the ODT to HTML using LibreOffice in headless mode
  libreoffice --headless --convert-to html:"HTML (StarWriter)" --outdir "html" "$file"

  # Check if the conversion was successful
  if [ -f "$output_file" ]; then
    echo "Converted: $file -> $output_file"

    # Set the HTML title
    set_html_title "$output_file" "$filename"
  else
    echo "Error converting: $file"
  fi
done

rm -f ./html/*.gif
rm -f ./html/*.png
rm -f ./html/*.jpeg
rm -f ./html/*.jpg
rm -f ./html/*.svg