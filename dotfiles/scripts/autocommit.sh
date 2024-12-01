#!/bin/zsh

# Variables
PATH_LIST="path_list.txt"  # File containing the list of files and folder paths
COMMIT_MESSAGE="Automated commit of listed files and folders"  # Commit message
source ~/.zshrc
# Check if the path list file exists
if [[ ! -f "$PATH_LIST" ]]; then
    echo "Error: File '$PATH_LIST' not found."
    exit 1
fi

# Add files and folders to the staging area
while IFS= read -r path; do
    if [[ -f "$path" ]]; then
        # If it's a file, stage it
        bare add "$path"
        echo "Staged file: $path"
    elif [[ -d "$path" ]]; then
        # If it's a folder, stage it recursively
        bare add "$path"
        echo "Staged folder: $path"
    else
        # If the path doesn't exist, warn the user
        echo "Warning: Path '$path' does not exist. Skipping."
    fi
done < "$PATH_LIST"

# Check if there are changes to commit
if bare diff --cached --quiet; then
    echo "No changes to commit."
    exit 0
fi

# Commit and push changes
bare commit -m "$COMMIT_MESSAGE"
if bare push; then
    echo "Changes pushed to remote repository successfully."
else
    echo "Error: Failed to push changes. Check your repository configuration."
    exit 1
fi
