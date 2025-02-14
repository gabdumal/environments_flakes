files=()
while IFS= read -r file; do
    files+=("$file")
done < <(ls ~/dotfiles/environments/ | grep -v -e 'README.md' -e 'update.sh')

for file in "${files[@]}"; do
    cd ~/dotfiles/environments/$file
    nix flake update
    cd ..
done
