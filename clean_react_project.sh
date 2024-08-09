#!/bin/bash

# Ask the user to provide an application name or use the default name "Clean App"
default_app_name="Clean App"
echo "Enter the application name (default: $default_app_name): "

# Read the user input into app_name
read app_name

# If the user presses Enter without providing a name, use the default name
if [ -z "$app_name" ]; then
  app_name="$default_app_name"
fi

echo -e "\033[32m++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+           Cleaning the React project           +"
echo -e "++++++++++++++++++++++++++++++++++++++++++++++++++\033[0m"

# Check if the project directory is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <project_directory>"
  exit 1
fi

# Get the project directory from the first argument
project_dir="$1"

# Define arrays of files to delete and empty relative to the project directory
filesToDelete=(
  "public/favicon.ico"
  "public/logo192.png"
  "public/logo512.png"
  "public/robots.txt"
  "src/App.test.js"
  "src/logo.svg"
  "src/reportWebVitals.js"
  "src/setupTests.js"
)
filesToEmpty=(
  "src/App.css"
  "src/index.css"
)

# Function to delete files
delete_files() {
  echo "Starting to delete files..."
  for file in "${filesToDelete[@]}"; do
    full_path="$project_dir/$file"
    echo "Checking $full_path"
    if [ -f "$full_path" ]; then
      rm -f "$full_path"
      echo "Deleted $full_path"
    else
      echo -e "\033[31mError deleting $full_path: File not found\033[0m"
    fi
  done
  echo "Finished deleting files."
}

# Function to empty files
empty_files() {
  echo "Starting to empty files..."
  for file in "${filesToEmpty[@]}"; do
    full_path="$project_dir/$file"
    echo "Checking $full_path"
    if [ -f "$full_path" ]; then
      echo "" > "$full_path"
      echo "Emptied $full_path"
    else
      echo -e "\033[31mError emptying $full_path: File not found\033[0m"
    fi
  done
  echo "Finished emptying files."
}

# Function to update files using sed
update_files() {
  echo "Starting to update files..."
  sed -i '' '/logo192.png/d' "$project_dir/public/manifest.json"
  sed -i '' '/logo512.png/d' "$project_dir/public/manifest.json"
  sed -i '' "s/React App/$app_name/g" "$project_dir/public/index.html"
  sed -i '' "/import logo from '.\/logo.svg';/d" "$project_dir/src/App.js"
  sed -i '' '/<header className="App-header">/,/<\/header>/d' "$project_dir/src/App.js"
  sed -i '' '/<div className="App">/a\
    <h1>'"$app_name"'</h1>\
' "$project_dir/src/App.js"
  sed -i '' "s/Create React App Sample/$app_name/g" "$project_dir/public/manifest.json"
  sed -i '' "s/React App/$app_name/g" "$project_dir/public/manifest.json"
  sed -i '' '/^\/\/.*/d' "$project_dir/src/index.js"
  sed -i '' '/reportWebVitals/d' "$project_dir/src/index.js"
  echo "Finished updating files."
}

# Execute functions
delete_files
empty_files
update_files
