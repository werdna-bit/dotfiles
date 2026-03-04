#!/bin/bash

echo "Installing packages from install-list.txt..."

# Install official repo packages
sudo pacman -S --needed $(grep -v "^#" install-list.txt | grep -v "\-bin$" | grep -v "\-git$")

echo ""
echo "AUR packages detected. Install yay first if not installed:"
echo "  git clone https://aur.archlinux.org/yay.git"
echo "  cd yay && makepkg -si"
echo ""
echo "Then install AUR packages:"
grep -E "\-bin$|\-git$" install-list.txt | while read pkg; do
    echo "  yay -S $pkg"
done
