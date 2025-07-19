# modules/nixos/security/onepassword.nix
{ ... }:
{
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "erik" ];
  };
}
