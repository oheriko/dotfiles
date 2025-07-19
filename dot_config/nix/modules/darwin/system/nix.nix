# modules/darwin/system/nix.nix
{ ... }:
{
  nix = {
    enable = false;
    settings.experimental-features = "nix-command flakes";
  };

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };

  system.stateVersion = 5;
}
