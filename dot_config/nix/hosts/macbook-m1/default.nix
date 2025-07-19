# hosts/macbook-m1/default.nix
{
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [
    # Shared modules
    ../../modules/shared/users.nix
    ../../modules/shared/fonts.nix
    ../../modules/shared/development.nix

    # Darwin-specific modules
    ../../modules/darwin/system
    ../../modules/darwin/security/touchid.nix
    ../../modules/darwin/homebrew.nix
    ../../modules/darwin/desktop/dock.nix
    ../../modules/darwin/desktop/finder.nix
    ../../modules/darwin/desktop/defaults.nix
  ];

  system.primaryUser = "erik";

  networking.hostName = "macbook-m1";

  environment.systemPackages = with pkgs; [
    curl
  ];
}
