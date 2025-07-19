# modules/nixos/system/default.nix
{ ... }:
{
  imports = [
    ./boot.nix
    ./nix.nix
    ./networking.nix
    ./users.nix
  ];
}
