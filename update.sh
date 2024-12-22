# Define an array of folder paths
folders=(
    "c_cpp"
    "latex"
    "rust"
    "typescript"
    "typst"
)

cd ~/.dotfiles/nixos/environments` || { echo "Failed to cd into ~/.dotfiles/nixos/environments"; exit 1; }

# Loop through each folder path
for folder in "${folders[@]}"; do
    # Change directory to the folder
    cd "$folder" || { echo "Failed to cd into $folder"; exit 1; }
    
    # Execute the command
    nix flake update
    
    # Return to the original directory
    cd - || exit
done
