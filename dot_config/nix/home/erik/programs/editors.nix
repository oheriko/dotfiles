# home/erik/programs/editors.nix
{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Optional: Add configuration for other editors
  programs.vscode = {
    enable = false; # Set to true if you use VS Code
  };
}
