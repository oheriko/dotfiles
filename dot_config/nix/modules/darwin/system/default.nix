# modules/darwin/system/default.nix
{ ... }:
{
  imports = [
    ./nix.nix
    ./keyboard.nix
    ./power.nix
    ./users.nix
  ];
}
