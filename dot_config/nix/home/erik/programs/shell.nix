# home/erik/programs/shell.nix
{ config, ... }:
{
  programs.starship.enable = true;
  programs.zoxide.enable = true;
  programs.fzf.enable = true;
}
