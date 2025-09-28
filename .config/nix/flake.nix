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
          pkgs.air
          pkgs.biome
          pkgs.bun
          pkgs.delve
          pkgs.dive
          pkgs.gcc
          pkgs.go
          pkgs.gopls
          pkgs.gotools
          pkgs.lua
          pkgs.lua-language-server
          pkgs.nixfmt-rfc-style
          pkgs.nodejs_24
          pkgs.python314
          pkgs.stylua
          pkgs.typescript-language-server
          pkgs.yamlfmt
        ];

        # shellHook = ''
        #   export LD_LIBRARY_PATH="$(dirname $(${pkgs.gcc}/bin/gcc --print-file-name=libstdc++.so.6)):$LD_LIBRARY_PATH"
        # '';
      };
    };
}
