{
  description = "My first Flake!";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    hyprland.url = "github:hyprwm/Hyprland";
  };
  outputs = { self, nixpkgs, ... } @ inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [ ./configuration.nix ];
      };
    };
  };
}
