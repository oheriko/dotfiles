# modules/nixos/security/keyd.nix
{ ... }:
{
  services.keyd = {
    enable = true;
    keyboards.defaults = {
      ids = [ "*" ];
      settings.main = {
        capslock = "overload(control, esc)";
      };
    };
  };
}
