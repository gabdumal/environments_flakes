files=()
while IFS= read -r file; do
    files+=("$file")
done < <(ls ~/.dotfiles/nixos/environments/ | grep -v -e 'README.md' -e 'update.sh')

for file in "${files[@]}"; do
    cd ~/.dotfiles/nixos/environments/$file
    nix flake update
    cd ..
done
