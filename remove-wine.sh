#!/bin/bash

echo "This script will remove leftover files from wine applications."

# Remove menu entries
read -p "Remove wine menu entries? (y/n): " remove_menus
if [[ $remove_menus == "y" ]]; then
  echo "Removing wine menu entries..."
  rm -f $HOME/.config/menus/applications-merged/wine*
fi

# Remove .desktop files
read -p "Remove wine .desktop files? (y/n): " remove_desktop_files
if [[ $remove_desktop_files == "y" ]]; then
  echo "Removing wine .desktop files..."
  rm -rf $HOME/.local/share/applications/wine
  rm -f $HOME/.local/share/desktop-directories/wine*
fi

# Remove icons
read -p "Remove wine icons? (y/n): " remove_icons
if [[ $remove_icons == "y" ]]; then
  echo "Removing wine icons..."
  rm -f $HOME/.local/share/icons/????_*.{xpm,png}
  rm -f $HOME/.local/share/icons/*-x-wine-*.{xpm,png}
fi

# Remove .wine directory
read -p "Remove the .wine directory? (y/n): " remove_wine
if [[ $remove_wine == "y" ]]; then
  echo "Removing the .wine directory..."
  echo "This will permanently remove all wine applications and their configuration files."
  read -p "Are you sure you want to proceed? (y/n): " confirm_remove_wine
  if [[ $confirm_remove_wine == "y" ]]; then
    rm -rf $HOME/.wine
  fi
fi

echo "The script has finished running."
echo "Please manually delete any leftover launchers for wine applications."
