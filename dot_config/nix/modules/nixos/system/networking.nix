# modules/nixos/system/network.nix
{ ... }:
{
  networking = {
    hostName = "nixos"; # Will be overridden by host configs
    networkmanager.enable = true;
  };
}
