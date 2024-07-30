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
