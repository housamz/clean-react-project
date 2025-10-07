# Generic React Project Cleaner

A comprehensive shell script to clean up unnecessary boilerplate files from various types of React projects. This script supports multiple React project types including Create React App, Vite, Next.js, and other custom setups.

## Features

- **Multi-framework support**: Works with Create React App, Vite, Next.js, and other React projects
- **Auto-detection**: Automatically detects project type by analyzing `package.json`
- **Interactive setup**: Prompts for project name and friendly display name
- **Safe operation**: Confirms before making changes and provides colored output
- **Flexible usage**: Can target any project directory or work in current directory

## Supported Project Types

### Create React App
Removes and cleans:
- `public/favicon.ico`
- `public/logo192.png` 
- `public/logo512.png`
- `public/robots.txt`
- `src/App.test.js` / `src/App.test.tsx`
- `src/logo.svg`
- `src/reportWebVitals.js` / `src/reportWebVitals.ts`
- `src/setupTests.js` / `src/setupTests.ts`
- Empties `src/App.css` and `src/index.css`

### Vite
Removes and cleans:
- `public/vite.svg`
- `src/assets/react.svg`
- Empties `src/App.css` and `src/index.css`

### Next.js
Removes and cleans:
- `public/next.svg`
- `public/vercel.svg`
- Empties CSS files in `src/app/` or `app/` directories

### Other/Custom Projects
- Empties common CSS files
- Updates `package.json` name field

## File Updates

The script intelligently updates various files based on project type:

### Common Updates (All Projects)
- **`package.json`**: Updates the "name" field with your project name
- **CSS files**: Empties boilerplate styles to give you a clean slate

### Create React App Specific
- **`public/manifest.json`**: 
  - Removes logo references
  - Updates app name and description
- **`public/index.html`**: Updates page title
- **`src/App.js` / `src/App.tsx`**: 
  - Removes logo imports
  - Removes boilerplate header content
  - Adds clean heading with your app name
- **`src/index.js` / `src/index.tsx`**: 
  - Removes comments
  - Removes `reportWebVitals` imports and usage

### Vite Specific
- **`index.html`**: Updates page title
- **`src/App.tsx`**: 
  - Removes asset imports (vite.svg, react.svg)
  - Replaces boilerplate content with clean structure

## Usage

### Basic Usage

1. **Make the script executable:**
   ```bash
   chmod +x clean-project.sh
   ```

2. **Run the script:**
   ```bash
   # Clean a specific project directory
   ./clean-project.sh /path/to/your/react/project
   
   # Clean the current directory
   ./clean-project.sh
   ```

### Examples

```bash
# Clean a project in your home directory
./clean-project.sh ~/dev/my-react-app

# Clean a project with absolute path
./clean-project.sh /Users/username/projects/ecommerce-site

# Clean the current directory (if you're already in the project folder)
./clean-project.sh
```

### Interactive Process

When you run the script, it will:

1. **Detect/Select Project Type:**
   ```
   What type of React project is this?
   1) Create React App
   2) Vite  
   3) Next.js
   4) Other/Custom
   5) Auto-detect
   ```

2. **Enter Project Details:**
   ```
   Enter the project name (kebab-case, e.g., career-guide) (default: clean-app):
   Enter the friendly name (e.g., Career Guide) (default: Clean App):
   ```

3. **Confirm Operation:**
   ```
   This will clean your React project. Continue? (y/N):
   ```

4. **Watch the Cleaning Process:**
   The script provides colored output showing what files are being deleted, emptied, and updated.

## Example Session

```bash
$ ./clean-project.sh ~/dev/my-ecommerce-app

==================================================
        Generic React Project Cleaner
==================================================
Working in directory: /Users/username/dev/my-ecommerce-app

What type of React project is this?
1) Create React App
2) Vite
3) Next.js
4) Other/Custom
5) Auto-detect

Enter your choice (1-5) [5]: 5
Detected/Selected project type: vite

Enter the project name (kebab-case, e.g., career-guide) (default: clean-app): 
my-ecommerce-app
Enter the friendly name (e.g., Career Guide) (default: Clean App): 
My E-commerce App

Project name: my-ecommerce-app
Friendly name: My E-commerce App

This will clean your React project. Continue? (y/N): y

++++++++++++++++++++++++++++++++++++++++++++++++++
+           Cleaning the React project           +
++++++++++++++++++++++++++++++++++++++++++++++++++

Starting to delete files...
✓ Deleted public/vite.svg
✓ Deleted src/assets/react.svg

Starting to empty CSS files...
✓ Emptied src/App.css
✓ Emptied src/index.css

Starting to update files...
✓ Updated index.html title
✓ Updated package.json name
✓ Updated App.tsx

==================================================
     Project cleaning completed successfully!
==================================================
Your vite project 'My E-commerce App' is now clean!
You can start building your application.
```

## Requirements

- **Operating System**: macOS/Linux (uses `sed` with BSD syntax)
- **Shell**: Bash
- **Permissions**: Write access to the target project directory

## Safety Features

- **Confirmation prompt**: Always asks before making changes
- **Error handling**: Exits on any error with `set -e`
- **File existence checks**: Only attempts to modify files that exist
- **Clear feedback**: Colored output shows exactly what actions are performed

## Installation

1. **Download the script:**
   ```bash
   curl -O https://raw.githubusercontent.com/your-repo/clean-project.sh
   # or
   wget https://raw.githubusercontent.com/your-repo/clean-project.sh
   ```

2. **Make it executable:**
   ```bash
   chmod +x clean-project.sh
   ```

3. **Optional: Add to PATH for global usage:**
   ```bash
   sudo mv clean-project.sh /usr/local/bin/clean-react-project
   ```

## Contributing

Feel free to submit issues and enhancement requests! This script is designed to be easily extensible for new React project types and frameworks.

## License

This project is open source and available under the [MIT License](LICENSE)
