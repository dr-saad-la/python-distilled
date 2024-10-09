#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if 'jb' (jupyter-book) is installed
if ! command_exists jb; then
    echo "Error: 'jb' (jupyter-book) is not installed. Please install it using 'pip install jupyter-book'."
    exit 1
fi

# Clean the previous build
echo "Cleaning previous Jupyter Book build..."
if ! jb clean book; then
    echo "Error: Failed to clean the Jupyter Book. Please check for issues."
    exit 1
fi
echo "Clean successful."

# Build the Jupyter Book
echo "Building the Jupyter Book..."
if ! jb build Book; then
    echo "Error: Build failed. Please check the error messages above."
    exit 1
fi
echo "Build successful."

# Check if the output file exists before trying to open it
OUTPUT_FILE="book/_build/html/index.html"
if [ -f "$OUTPUT_FILE" ]; then
    echo "Opening the Jupyter Book in your default browser..."
    if ! open "$OUTPUT_FILE"; then
        echo "Error: Could not open '$OUTPUT_FILE'. Please open it manually."
    else
        echo "Jupyter Book opened successfully!"
    fi
else
    echo "Error: The build output '$OUTPUT_FILE' was not found. Please check the build logs."
    exit 1
fi
