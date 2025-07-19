# modules/darwin/homebrew.nix
{ ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };

    taps = [ ];

    brews = [
      "coreutils"
    ];

    casks = [
      "1password"
      "beekeeper-studio"
      "bitwarden"
      "chromium"
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
      "yubico-authenticator"
    ];

    masApps = {
      slack = 803453959;
    };
  };
}
