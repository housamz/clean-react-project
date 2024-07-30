#!/bin/bash

# Check if the project directory is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <project_directory>"
  exit 1
fi

# Get the project directory from the first argument
project_dir="$1"

# Array of files to delete relative to the project directory
filesToDelete=(
  "public/logo192.png"
  "public/logo512.png"
  "public/robots.txt"
  "public/favicon.ico"
  "src/logo.svg"
  "src/App.css"
  "src/App.test.js"
  "src/index.css"
  "src/logo.svg"
  "src/reportWebVitals.js"
  "src/setupTests.js"
)

# Loop through the array and delete each file
for file in "${filesToDelete[@]}"; do
  full_path="$project_dir/$file"
  if [ -f "$full_path" ]; then
    rm "$full_path"
    echo "Deleted $full_path"
  else
    echo "Error deleting $full_path: File not found"
  fi
done
