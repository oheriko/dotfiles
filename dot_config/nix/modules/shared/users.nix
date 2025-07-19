# modules/shared/users.nix
{ pkgs, ... }:
{
  users.users.erik =
    {
      description = "Erik Wright";
      shell = pkgs.zsh;
    }
    // (
      if pkgs.stdenv.isDarwin then
        {
          home = "/Users/erik";
        }
      else
        {
          isNormalUser = true;
          extraGroups = [
            "networkmanager"
            "wheel"
          ];
        }
    );
}
