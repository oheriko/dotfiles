# home/erik/programs/default.nix
{ ... }:
{
  imports = [
    ./shell.nix
    ./editors.nix
    ./direnv.nix
  ];
}
