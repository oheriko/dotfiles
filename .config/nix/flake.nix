{
  description = "Home Manager configuration of erik";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mcp-hub.url = "github:ravitemer/mcp-hub";
    mcphub-nvim.url = "github:ravitemer/mcphub.nvim";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };
  outputs =
    {
      nixpkgs,
      home-manager,
      mcp-hub,
      mcphub-nvim,
      neovim-nightly,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ neovim-nightly.overlays.default ];
        config.allowUnfreePredicate =
          pkg:
          builtins.elem (nixpkgs.lib.getName pkg) [
            "lmstudio"
          ];

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
          mcp-hub.packages."${system}".default
          mcphub-nvim.packages."${system}".default
          pkgs.nixfmt-rfc-style
          pkgs.nodejs_24
          pkgs.openssl
          pkgs.python313
          pkgs.rustc
          pkgs.cargo
          pkgs.stylua
          pkgs.typescript-language-server
          pkgs.yamlfmt
        ];

        shellHook = ''
          #   export LD_LIBRARY_PATH="$(dirname $(${pkgs.gcc}/bin/gcc --print-file-name=libstdc++.so.6)):$LD_LIBRARY_PATH"
        '';
      };
    };
}
