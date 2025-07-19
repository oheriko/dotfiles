# modules/darwin/default.nix
{
  desktop = import ./desktop;
  security = import ./security;
  system = import ./system;
  homebrew = import ./homebrew.nix;
}
