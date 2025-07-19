# flake.nix
{
  description = "Erik's NixOS and Darwin configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # Add other inputs as needed
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      nix-darwin,
      home-manager,
      ...
    }@inputs:
    let
      # Remove this line - it's causing the infinite recursion:
      # inherit (self) outputs;

      # Supported systems
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      # Helper function to generate an attribute set for each system
      forAllSystems = nixpkgs.lib.genAttrs systems;

      # Helper function to create system configurations
      mkSystem =
        hostname: system: extraModules:
        if nixpkgs.lib.strings.hasSuffix "darwin" system then
          nix-darwin.lib.darwinSystem {
            inherit system;
            specialArgs = { inherit inputs; }; # Remove outputs from here
            modules = [
              ./hosts/${hostname}
              home-manager.darwinModules.home-manager
              {
                home-manager = {
                  backupFileExtension = "~";
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.erik = import ./home/erik;
                  extraSpecialArgs = { inherit inputs nixpkgs-stable; };
                };
              }
            ] ++ extraModules;
          }
        else
          nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs; }; # Remove outputs from here
            modules = [
              ./hosts/${hostname}
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  backupFileExtension = "~";
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.erik = import ./home/erik;
                  extraSpecialArgs = { inherit inputs nixpkgs-stable; }; # Remove outputs
                };
              }
            ] ++ extraModules;
          };
    in
    {
      # Custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };

      # Reusable nixos modules
      nixosModules = import ./modules/nixos;

      # Reusable darwin modules
      darwinModules = import ./modules/darwin;

      # Reusable home-manager modules
      homeManagerModules = import ./home/modules;

      # Development shells
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              git
              nixfmt-rfc-style
            ];
          };
        }
      );

      # NixOS configurations
      nixosConfigurations = {
        laptop-hp = mkSystem "laptop-hp" "x86_64-linux" [ ];
      };

      # Darwin configurations
      darwinConfigurations = {
        macbook-m1 = mkSystem "macbook-m1" "aarch64-darwin" [ ];
      };

      # Standalone home-manager configurations
      homeConfigurations = {
        "erik@laptop-hp" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs nixpkgs-stable; }; # Remove outputs
          modules = [ ./home/erik ];
        };

        "erik@macbook-m1" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = { inherit inputs nixpkgs-stable; }; # Remove outputs
          modules = [ ./home/erik ];
        };
      };
    };
}
