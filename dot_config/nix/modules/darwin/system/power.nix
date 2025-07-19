# modules/darwin/system/power.nix
{ ... }:
{
  power.sleep = {
    computer = "never";
    display = "never";
  };
}
