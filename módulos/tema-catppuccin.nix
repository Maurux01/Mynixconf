{ config, pkgs, ... }:
{
  catppuccin.enable = true;
  catppuccin.flavour = "mocha";
  catppuccin.accent = "blue";
  environment.sessionVariables = {
    GTK_THEME = "Catppuccin-Mocha-Standard-Blue-Dark";
    QT_STYLE_OVERRIDE = "Catppuccin-Mocha";
  };
}
