# lib/default.nix
{ inputs, ... }:
{
  # Helper functions
  mkHost = import ./mkhost.nix { inherit inputs; };
  # Add other helper functions as needed
}
