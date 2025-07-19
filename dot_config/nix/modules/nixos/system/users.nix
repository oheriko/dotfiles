# modules/nixos/system/users.nix
{ pkgs, ... }:
{
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
}
