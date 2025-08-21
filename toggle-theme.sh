#!/usr/bin/env bash
# Toggle between Catppuccin Mocha and Latte for GTK, Qt, and terminal

set -e

USER_CONFIG="$HOME/.config"
GTKRC="$USER_CONFIG/gtk-3.0/settings.ini"
QT5CTRC="$USER_CONFIG/qt5ct/qt5ct.conf"
KITTYRC="$USER_CONFIG/kitty/kitty.conf"
ROFIRC="$USER_CONFIG/rofi/config.rasi"

if grep -q 'Catppuccin-Mocha' "$GTKRC"; then
  # Switch to Latte
  sed -i 's/Catppuccin-Mocha.*/Catppuccin-Latte-Standard-Mauve-Light/' "$GTKRC"
  sed -i 's/Catppuccin-Mocha.*/Catppuccin-Latte/' "$QT5CTRC"
  sed -i 's/theme = .*/theme = "Catppuccin-Latte"/' "$KITTYRC"
  sed -i 's/catppuccin-mocha/catppuccin-latte/' "$ROFIRC"
  notify-send "Theme toggled to Catppuccin Latte"
else
  # Switch to Mocha
  sed -i 's/Catppuccin-Latte.*/Catppuccin-Mocha-Standard-Mauve-Dark/' "$GTKRC"
  sed -i 's/Catppuccin-Latte.*/Catppuccin-Mocha/' "$QT5CTRC"
  sed -i 's/theme = .*/theme = "Catppuccin-Mocha"/' "$KITTYRC"
  sed -i 's/catppuccin-latte/catppuccin-mocha/' "$ROFIRC"
  notify-send "Theme toggled to Catppuccin Mocha"
fi
