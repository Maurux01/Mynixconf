#!/usr/bin/env bash
# Cambia entre Catppuccin Mocha y Latte para GTK, Qt, kitty y rofi
set -e
#!/usr/bin/env bash
# Alterna entre Catppuccin Mocha y Latte para GTK
current=$(gsettings get org.gnome.desktop.interface gtk-theme)
if [[ $current == *"Mocha"* ]]; then
  gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-Latte-Standard-Blue-Light"
else
  gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-Mocha-Standard-Blue-Dark"
fi
