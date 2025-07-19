# home/shared/packages.nix
{ pkgs, ... }:
{
  # Shared packages across all users/systems
  home.packages = with pkgs; [
    # Core utilities
    curl
    wget
    git

    # Development
    direnv

    # Shell utilities
    fzf
    ripgrep
    fd
    eza

    # Text processing
    jq
    yq
  ];
}
