# Clean React Project Script

This repository contains a shell script to clean up unnecessary files from a React project. The script will delete the following files within the specified project directory if they exist:

- `public/logo192.png`
- `public/logo512.png`
- `public/robots.txt`
- `public/favicon.ico`
- `src/logo.svg`
- `src/App.css`
- `src/App.test.js`
- `src/index.css`
- `src/reportWebVitals.js`
- `src/setupTests.js`

Additionally, the script will update the following files:

- `public/manifest.json`
  - Remove references to `logo192.png` and `logo512.png`
  - Replace "React App" and "Create React App Sample" with the provided application name
- `public/index.html`
  - Replace "React App" with the provided application name
- `src/App.js`
  - Remove the import statement for `logo.svg`
  - Remove the `<header>` element
  - Add an `<h1>` element with the provided application name inside the `<div className="App">`
- `src/index.js`
  - Remove comments
  - Remove the `reportWebVitals` import and its usage


## Usage

1. **Clone the repository:**

   ```sh
   git clone https://github.com/housamz/clean-react-project.git
   cd clean-react-project
   ```

2. **Make the script executable:**

   ```sh
   chmod +x clean_react_project.sh
   ```

3. **Run the script with the path to your React project directory:**

   ```sh
   ./clean_react_project.sh /path/to/your/react/project

    # Example:
    # If your React project is located at /home/user/react-app, run:
    # ./clean_react_project.sh /home/user/react-app
   ```
4. **Provide the application name when prompted:**
The script will ask for an application name. If you press Enter without providing a name, it will use the default name "Clean App".