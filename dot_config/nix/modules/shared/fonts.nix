# modules/shared/fonts.nix
{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    nerd-fonts.monaspace
    nerd-fonts.caskaydia-cove
    nerd-fonts.caskaydia-mono
  ];
}
