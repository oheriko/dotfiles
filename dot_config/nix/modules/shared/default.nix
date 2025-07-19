# modules/shared/default.nix
{
  users = import ./users.nix;
  locale = import ./locale.nix;
  fonts = import ./fonts.nix;
  development = import ./development.nix;
}
