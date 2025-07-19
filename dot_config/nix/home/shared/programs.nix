# home/shared/programs.nix
{ ... }:
{
  # Shared program configurations
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      extraConfig = {
        init.defaultBranch = "main";
        push.default = "simple";
        pull.rebase = true;
      };
    };
  };
}
