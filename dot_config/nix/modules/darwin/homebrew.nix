# modules/darwin/homebrew.nix
{ ... }:
{
  homebrew = {
    enable = true;
    # onActivation = {
    #   cleanup = "zap";
    #   autoUpdate = true;
    #   upgrade = true;
    # };
    taps = [ ];
    brews = [
      "coreutils"
      "zsh-autosuggestions"
    ];
    casks = [
      # "1password"
      "beekeeper-studio"
      "bitwarden"
      "docker"
      "getoutline"
      "ghostty"
      "keybase"
      "lm-studio"
      "mullvadvpn"
      "ngrok"
      "notion"
      "ollama"
      "raycast"
      "ungoogled-chromium"
      "yubico-authenticator"
    ];
    masApps = {
      slack = 803453959;
    };
  };
}
