# modules/darwin/security/touchid.nix
{ ... }:
{
  security.pam.services.sudo_local.touchIdAuth = true;
}
