# home/erik/packages.nix
{
  inputs,
  pkgs,
  nixpkgs-stable,
  lib,
  ...
}:
let
  # Create stable packages set for your system
  stable = import nixpkgs-stable {
    system = pkgs.system;
    config = pkgs.config;
  };
in
{
  home.packages =
    with pkgs;
    [
      # Development tools
      chezmoi
      direnv
      git
      lazygit

      # CLI utilities
      bat
      eza
      fd
      fzf
      jq
      yq
      ripgrep
      starship
      zoxide
      zsh-autosuggestions

      # File management
      rclone
      yazi
      unzip

      # Security
      age
      age-plugin-yubikey
      # stable.bitwarden-cli
      sops
      yubikey-manager

      # System tools
      # btop
      # htop
      duf
      dust
      fastfetch
      procs
      bandwhich
      podman
      podman-compose
      podman-tui

      # Media
      ffmpeg
      imagemagick

      # Browsers and applications
      firefox-unwrapped
      thunderbird-latest-unwrapped

      # Development environments
      # neovim-nightly-overlay.packages.${system}.default
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      # Linux-specific packages
      biome
      bitwarden-desktop
      beekeeper-studio
      clang
      cloudflared
      cryptomator
      czkawka
      dbeaver-bin
      diceware
      dive
      ghostty
      hyprpolkitagent
      keybase-gui
      lazysql
      loupe
      mullvad-browser
      obs-studio
      overskride
      pinentry-tty
      poppler
      swaynotificationcenter
      tutanota-desktop
      ungoogled-chromium
      vaultwarden
      vmware-workstation
      waybar
      wofi
      # zen-browser.packages."${system}".default
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin [
      # Darwin-specific packages
      bruno
      bruno-cli
      bws
      nixfmt-rfc-style
      openssh
      tig
      turso-cli
    ];
}
