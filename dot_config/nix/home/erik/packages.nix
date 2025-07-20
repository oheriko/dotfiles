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
    [
      # Development tools
      pkgs.chezmoi
      pkgs.direnv
      pkgs.git
      pkgs.lazygit
      pkgs.tree-sitter

      # CLI utilities
      pkgs.bat
      pkgs.eza
      pkgs.fd
      pkgs.fzf
      pkgs.jq
      pkgs.yq
      pkgs.ripgrep
      pkgs.starship
      pkgs.zoxide
      pkgs.zsh-autosuggestions

      # File management
      pkgs.rclone
      pkgs.yazi
      pkgs.unzip

      # Security
      pkgs.age
      pkgs.age-plugin-yubikey
      # stable.bitwarden-cli
      pkgs.sops
      pkgs.yubikey-manager

      # System tools
      # btop
      # htop
      pkgs.duf
      pkgs.dust
      pkgs.fastfetch
      pkgs.procs
      pkgs.bandwhich
      pkgs.podman
      pkgs.podman-compose
      pkgs.podman-tui

      # Media
      pkgs.ffmpeg
      pkgs.imagemagick

      # Browsers and applications
      pkgs.firefox-unwrapped
      pkgs.thunderbird-latest-unwrapped

      # Development environments
      # neovim-nightly-overlay.packages.${system}.default
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      # Linux-specific packages
      pkgs.biome
      pkgs.bitwarden-desktop
      pkgs.eekeeper-studio
      pkgs.lang
      pkgs.cloudflared
      pkgs.cryptomator
      pkgs.czkawka
      pkgs.dbeaver-bin
      pkgs.diceware
      pkgs.dive
      pkgs.ghostty
      pkgs.hyprpolkitagent
      pkgs.keybase-gui
      pkgs.lazysql
      pkgs.loupe
      pkgs.mullvad-browser
      pkgs.obs-studio
      pkgs.overskride
      pkgs.pinentry-tty
      pkgs.poppler
      pkgs.swaynotificationcenter
      pkgs.ungoogled-chromium
      pkgs.vaultwarden
      pkgs.vmware-workstation
      pkgs.waybar
      pkgs.wofi
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin [
      # Darwin-specific packages
      pkgs.bruno
      pkgs.bruno-cli
      pkgs.bws
      pkgs.nixfmt-rfc-style
      pkgs.openssh
      # pkgs.tig
      pkgs.turso-cli
    ];
}
