# lib/mkhost.nix
{ inputs }:
hostname: system: modules:
if builtins.match ".*darwin.*" system != null then
  inputs.nix-darwin.lib.darwinSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [ ../hosts/${hostname} ] ++ modules;
  }
else
  inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [ ../hosts/${hostname} ] ++ modules;
  }
