# modules/darwin/desktop/finder.nix
{ ... }:
{
  system.defaults.finder = {
    _FXShowPosixPathInTitle = false;
    _FXSortFoldersFirst = true;
    AppleShowAllExtensions = true;
    AppleShowAllFiles = false;
    CreateDesktop = true;
    FXDefaultSearchScope = "SCcf";
    FXEnableExtensionChangeWarning = false;
    FXPreferredViewStyle = "clmv";
    QuitMenuItem = false;
    ShowPathbar = true;
    ShowStatusBar = false;
  };
}
