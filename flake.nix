{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      thinkpad = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/thinkpad/configuration.nix
        ];
      };

      homepc = lib.nixosSystem {
        inherit system;
        modules = [./hosts/homepc/configuration.nix];
      };
    };

    homeConfigurations = {
      fulstaph = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./home.nix];
      };
    };
  };
}
