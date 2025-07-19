# modules/darwin/desktop/dock.nix
{ ... }:
{
  system.defaults.dock = {
    appswitcher-all-displays = true;
    autohide = true;
    autohide-delay = 0.0;
    autohide-time-modifier = 0.15;
    dashboard-in-overlay = false;
    enable-spring-load-actions-on-all-items = false;
    expose-animation-duration = 0.2;
    expose-group-apps = false;
    launchanim = true;
    mineffect = "genie";
    minimize-to-application = false;
    mouse-over-hilite-stack = true;
    mru-spaces = false;
    orientation = "bottom";
    show-process-indicators = true;
    show-recents = false;
    showhidden = true;
    static-only = false;
    tilesize = 48;
    wvous-bl-corner = 1;
    wvous-br-corner = 2;
    wvous-tl-corner = 1;
    wvous-tr-corner = 1;
    persistent-apps = [
      "/Applications/1Password.app"
      "/Applications/Ghostty.app"
      "/Applications/NeoHtop.app"
    ];
  };
}
