# modules/nixos/security/keybase.nix
{ ... }:
{
  services.keybase.enable = true;
  services.kbfs.enable = true;
}
