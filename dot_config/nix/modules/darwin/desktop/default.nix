# modules/darwin/desktop/default.nix
{
  dock = import ./dock.nix;
  finder = import ./finder.nix;
  defaults = import ./defaults.nix;
}
