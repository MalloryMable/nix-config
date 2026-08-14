  {
  description = "Modular NixOS Flake Configuration";

  inputs = {
    #NOTE: Updated in ~~May~~ June and ~~November~~ December
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
  };


  outputs = { self, nixpkgs, ... }@inputs:
  let
    vars = import ./variables.nix;
  in {
    nixosConfigurations = {
      # nixos-rebuild switch --flake .
       "${vars.hostName}" = nixpkgs.lib.nixosSystem {
        system = "${vars.system}";
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}
