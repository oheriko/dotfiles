# home/erik/default.nix
{
  inputs,
  outputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./packages.nix
    ./programs
    ./desktop
  ];

  home = {
    username = "erik";
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/erik" else "/home/erik";
    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;

  # Platform-specific configurations
  home.sessionVariables = lib.mkIf (!pkgs.stdenv.isDarwin) {
    XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
    XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
    XDG_STATE_HOME = "${config.home.homeDirectory}/.local/state";
    XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
  };
}
