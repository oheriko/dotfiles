{
  config,
  pkgs,
  ...
}:

{
  home.username = "erik";
  home.homeDirectory = "/home/erik";
  home.stateVersion = "25.05";
  home.packages = [
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    pkgs.bat
    pkgs.delta
    pkgs.direnv
    pkgs.eza
    pkgs.fd
    pkgs.fzf
    pkgs.git
    pkgs.httpie
    pkgs.jq
    pkgs.lazygit
    pkgs.llama-cpp
    pkgs.neovim
    pkgs.nix
    (pkgs.ollama.override {
      acceleration = "cuda";
    })
    pkgs.podman
    pkgs.podman-tui
    pkgs.podman-compose
    pkgs.ripgrep
    pkgs.starship
    pkgs.tree-sitter
    pkgs.unzip
    pkgs.yazi
    pkgs.yq
    pkgs.zellij
    pkgs.zoxide
  ];

  programs = {
    # bash.enable = true;
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
    home-manager.enable = true;
  };
}
