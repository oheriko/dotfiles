# hosts/laptop-hp/default.nix
{
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixpkgs.nixosModules.notDetected
    ./hardware.nix

    # Shared modules
    ../../modules/shared/users.nix
    ../../modules/shared/locale.nix
    ../../modules/shared/fonts.nix
    ../../modules/shared/development.nix

    # System configuration
    ../../modules/nixos/system

    # Desktop environment
    ../../modules/nixos/desktop/hyprland.nix
    ../../modules/nixos/desktop/wayland.nix
    ../../modules/nixos/desktop/audio.nix

    # Hardware
    ../../modules/nixos/hardware/bluetooth.nix

    # Security
    ../../modules/nixos/security/onepassword.nix
    ../../modules/nixos/security/keybase.nix
    ../../modules/nixos/security/keyd.nix
    ../../modules/nixos/security/vpn.nix

    # Development
    ../../modules/nixos/development/containers.nix
  ];

  networking.hostName = "laptop-hp";

  # Enable additional services
  services.openssh.enable = true;
  programs.light.enable = true;

  # System packages specific to this host
  environment.systemPackages = with pkgs; [
    age
    cryptsetup
    dig
    gparted
    openssl
    pinentry
    pinentry-tty
  ];

  system.stateVersion = "24.11";
}
