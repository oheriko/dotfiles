{
  description = "Home Manager configuration of erik";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };
  outputs =
    {
      nixpkgs,
      home-manager,
      neovim-nightly,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ neovim-nightly.overlays.default ];
      };
    in
    {
      homeConfigurations."erik" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.biome
          pkgs.bun
          pkgs.lua
          pkgs.lua-language-server
          pkgs.nixfmt-rfc-style
          pkgs.nodejs_24
          pkgs.stylua
          pkgs.typescript-language-server
        ];

        shellHook = ''
          echo "Base home environment loaded with Node.js $(node --version)"
        '';
      };
    };
}
