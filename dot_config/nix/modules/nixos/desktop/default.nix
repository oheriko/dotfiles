# modules/nixos/desktop/default.nix
{
  hyprland = import ./hyprland.nix;
  audio = import ./audio.nix;
  wayland = import ./wayland.nix;
}
