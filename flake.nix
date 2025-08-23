{
  description = "NixOS Modular Config estilo mitchellh";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { self, nixpkgs, home-manager, catppuccin, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations = {
        mi-host = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./máquinas/mi-host.nix
            catppuccin.nixosModules.catppuccin
          ];
        };
      };
      homeConfigurations = {
        "tu_usuario@mi-host" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./usuarios/tu_usuario/home.nix
            catppuccin.homeManagerModules.catppuccin
          ];
        };
      };
    };
}
