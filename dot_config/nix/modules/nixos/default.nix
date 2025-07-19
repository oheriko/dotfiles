# modules/nixos/default.nix
{
  desktop = import ./desktop;
  hardware = import ./hardware;
  security = import ./security;
  development = import ./development;
  system = import ./system;
}
