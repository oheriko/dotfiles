# modules/shared/development.nix
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    curl
    delta
    git
    gnupg
    openssh
  ];
}
