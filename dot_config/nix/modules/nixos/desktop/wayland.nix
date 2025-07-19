# modules/nixos/desktop/wayland.nix
{ pkgs, ... }:
{
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_BIN_HOME = "$HOME/.local/bin";
  };

  environment.systemPackages = with pkgs; [
    wayland
    wayland-utils
    wl-clipboard
    wlr-randr
  ];
}
