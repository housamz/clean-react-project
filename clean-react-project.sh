#!/bin/bash

# Generic React Project Cleaner
# Supports Create React App, Vite, and other React boilerplates

set -e  # Exit on any error

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_color() {
    echo -e "${1}${2}${NC}"
}

print_color $GREEN "=================================================="
print_color $GREEN "        Generic React Project Cleaner"
print_color $GREEN "=================================================="

# Check if the project directory is provided as argument
if [ -n "$1" ]; then
    project_dir="$1"
    cd "$project_dir"
    print_color $BLUE "Working in directory: $project_dir"
else
    project_dir="$(pwd)"
    print_color $BLUE "Working in current directory: $project_dir"
fi

# Detect project type
detect_project_type() {
    if [ -f "package.json" ]; then
        if grep -q "react-scripts" package.json; then
            echo "create-react-app"
        elif grep -q "vite" package.json; then
            echo "vite"
        elif grep -q "next" package.json; then
            echo "nextjs"
        else
            echo "other"
        fi
    else
        echo "unknown"
    fi
}

# Ask user for project type
echo ""
print_color $BLUE "What type of React project is this?"
echo "1) Create React App"
echo "2) Vite"
echo "3) Next.js"
echo "4) Other/Custom"
echo "5) Auto-detect"
echo ""
read -p "Enter your choice (1-5) [5]: " project_type_choice

case $project_type_choice in
    1) PROJECT_TYPE="create-react-app" ;;
    2) PROJECT_TYPE="vite" ;;
    3) PROJECT_TYPE="nextjs" ;;
    4) PROJECT_TYPE="other" ;;
    *) PROJECT_TYPE=$(detect_project_type) ;;
esac

print_color $YELLOW "Detected/Selected project type: $PROJECT_TYPE"

# Ask for project details with improved defaults
echo ""
default_project_name="clean-app"
echo "Enter the project name (kebab-case, e.g., career-guide) (default: $default_project_name): "
read project_name
project_name=${project_name:-$default_project_name}

default_friendly_name="Clean App"
echo "Enter the friendly name (e.g., Career Guide) (default: $default_friendly_name): "
read friendly_name
echo ""
print_color $GREEN "Project name: $project_name"
print_color $GREEN "Friendly name: $friendly_name"
echo ""

# Confirmation
read -p "This will clean your React project. Continue? (y/N): " confirm
if [[ ! $confirm =~ ^[Yy]$ ]]; then
    print_color $RED "Operation cancelled."
    exit 0
fi

echo ""
print_color $GREEN "++++++++++++++++++++++++++++++++++++++++++++++++++"
print_color $GREEN "+           Cleaning the React project           +"
print_color $GREEN "++++++++++++++++++++++++++++++++++++++++++++++++++"

# Define files to delete based on project type
declare -a filesToDelete
declare -a filesToEmpty

case $PROJECT_TYPE in
    "create-react-app")
        filesToDelete=(
            "public/favicon.ico"
            "public/logo192.png" 
            "public/logo512.png"
            "public/robots.txt"
            "src/App.test.js"
            "src/App.test.tsx"
            "src/logo.svg"
            "src/reportWebVitals.js"
            "src/reportWebVitals.ts"
            "src/setupTests.js"
            "src/setupTests.ts"
            "src/App.css"
        )
        filesToEmpty=(
            "src/index.css"
        )
        ;;
    "vite")
        filesToDelete=(
            "public/vite.svg"
            "src/assets/react.svg"
            "src/App.css"
        )
        filesToEmpty=(
            "src/index.css"
        )
        ;;
    "nextjs")
        filesToDelete=(
            "public/next.svg"
            "public/vercel.svg"
        )
        filesToEmpty=(
            "src/app/globals.css"
            "app/globals.css"
        )
        ;;
    *)
        print_color $YELLOW "Unknown project type. Only cleaning CSS files."
        filesToDelete=(
            "src/App.css"
        )
        filesToEmpty=(
            "src/index.css"
            "src/styles/globals.css"
        )
        ;;
esac

# Function to delete files
delete_files() {
    print_color $BLUE "Starting to delete files..."
    for file in "${filesToDelete[@]}"; do
        echo "Checking $file"
        if [ -f "$file" ]; then
            rm -f "$file"
            print_color $GREEN "✓ Deleted $file"
        else
            print_color $YELLOW "⚠ File not found: $file"
        fi
    done
    print_color $BLUE "Finished deleting files."
}

# Function to empty files
empty_files() {
    print_color $BLUE "Starting to empty CSS files..."
    for file in "${filesToEmpty[@]}"; do
        echo "Checking $file"
        if [ -f "$file" ]; then
            echo "" > "$file"
            print_color $GREEN "✓ Emptied $file"
        else
            print_color $YELLOW "⚠ File not found: $file"
        fi
    done
    print_color $BLUE "Finished emptying files."
}

# Function to update files based on project type
update_files() {
    print_color $BLUE "Starting to update files..."
    
    case $PROJECT_TYPE in
        "create-react-app")
            # Update manifest.json
            if [ -f "public/manifest.json" ]; then
                sed -i '' '/logo192.png/d' "public/manifest.json"
                sed -i '' '/logo512.png/d' "public/manifest.json"
                sed -i '' "s/Create React App Sample/$friendly_name/g" "public/manifest.json"
                sed -i '' "s/React App/$friendly_name/g" "public/manifest.json"
                print_color $GREEN "✓ Updated manifest.json"
            fi
            
            # Update index.html
            if [ -f "public/index.html" ]; then
                sed -i '' "s/React App/$friendly_name/g" "public/index.html"
                print_color $GREEN "✓ Updated index.html title"
            fi
            
            # Update App.js or App.tsx
            if [ -f "src/App.js" ]; then
                # Remove App.css import
                sed -i '' "/import.*App\.css.*;/d" "src/App.js"
                sed -i '' "/import logo from '.\/logo.svg';/d" "src/App.js"
                
                # Replace the entire function content with clean structure
                cat > "src/App.js" << EOF
function App() {
  return (
    <div className="App">
      <h1>$friendly_name</h1>
    </div>
  );
}

export default App;
EOF
                print_color $GREEN "✓ Updated App.js"
            elif [ -f "src/App.tsx" ]; then
                # Remove App.css import
                sed -i '' "/import.*App\.css.*;/d" "src/App.tsx"
                sed -i '' "/import.*logo.*from.*'.\/logo.svg';/d" "src/App.tsx"
                
                # Replace the entire function content with clean structure
                cat > "src/App.tsx" << EOF
function App() {
  return (
    <div className="App">
      <h1>$friendly_name</h1>
    </div>
  );
}

export default App;
EOF
                print_color $GREEN "✓ Updated App.tsx"
            fi
            
            # Update index.js or index.tsx
            if [ -f "src/index.js" ]; then
                sed -i '' '/^\/\/.*/d' "src/index.js"
                sed -i '' '/reportWebVitals/d' "src/index.js"
                print_color $GREEN "✓ Updated index.js"
            elif [ -f "src/index.tsx" ]; then
                sed -i '' '/^\/\/.*/d' "src/index.tsx"
                sed -i '' '/reportWebVitals/d' "src/index.tsx"
                print_color $GREEN "✓ Updated index.tsx"
            fi
            
            # Update package.json name
            if [ -f "package.json" ]; then
                sed -i '' "s/\"name\": \".*\"/\"name\": \"$project_name\"/g" "package.json"
                print_color $GREEN "✓ Updated package.json name"
            fi
            ;;
            
        "vite")
            # Update index.html
            if [ -f "index.html" ]; then
                sed -i '' "s/Vite + React/$friendly_name/g" "index.html"
                sed -i '' "s/<title>.*<\/title>/<title>$friendly_name<\/title>/g" "index.html"
                print_color $GREEN "✓ Updated index.html title"
            fi
            
            # Update package.json name
            if [ -f "package.json" ]; then
                sed -i '' "s/\"name\": \".*\"/\"name\": \"$project_name\"/g" "package.json"
                print_color $GREEN "✓ Updated package.json name"
            fi
            
            # Update App.tsx
            if [ -f "src/App.tsx" ]; then
                # Replace the entire file content with clean structure
                cat > "src/App.tsx" << EOF
function App() {
  return (
    <div className="App">
      <h1>$friendly_name</h1>
    </div>
  );
}

export default App;
EOF
                print_color $GREEN "✓ Updated App.tsx"
            elif [ -f "src/App.jsx" ]; then
                # Replace the entire file content with clean structure
                cat > "src/App.jsx" << EOF
function App() {
  return (
    <div className="App">
      <h1>$friendly_name</h1>
    </div>
  );
}

export default App;
EOF
                print_color $GREEN "✓ Updated App.jsx"
            fi
            ;;
            
        "nextjs")
            # Update package.json name
            if [ -f "package.json" ]; then
                sed -i '' "s/\"name\": \".*\"/\"name\": \"$project_name\"/g" "package.json"
                print_color $GREEN "✓ Updated package.json name"
            fi
            ;;
    esac
    
    print_color $BLUE "Finished updating files."
}

# Execute functions
delete_files
empty_files  
update_files

echo ""
print_color $GREEN "=================================================="
print_color $GREEN "     Project cleaning completed successfully!"
print_color $GREEN "=================================================="
print_color $YELLOW "Your $PROJECT_TYPE project '$friendly_name' is now clean!"
print_color $YELLOW "You can start building your application."
echo ""
