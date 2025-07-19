#!/usr/bin/env bash

# migrate-nix-config.sh
# Script to help migrate from old flat structure to new modular structure

set -euo pipefail

echo "🚀 Starting Nix configuration migration..."

# Create new directory structure
echo "📁 Creating new directory structure..."
mkdir -p {lib,modules/{nixos/{desktop,hardware,security,development,system},darwin/{desktop,security,system},shared},hosts/{laptop-hp,macbook-m1},home/{erik/programs,erik/desktop,modules,shared},overlays}

# Create module index files
echo "📄 Creating module index files..."

# NixOS modules index
cat > modules/nixos/default.nix << 'EOF'
{
  desktop = import ./desktop;
  hardware = import ./hardware;
  security = import ./security;
  development = import ./development;
  system = import ./system;
}
EOF

# Darwin modules index
cat > modules/darwin/default.nix << 'EOF'
{
  desktop = import ./desktop;
  security = import ./security;
  system = import ./system;
  homebrew = import ./homebrew.nix;
}
EOF

# Desktop modules
cat > modules/nixos/desktop/default.nix << 'EOF'
{
  hyprland = import ./hyprland.nix;
  audio = import ./audio.nix;
  wayland = import ./wayland.nix;
}
EOF

cat > modules/darwin/desktop/default.nix << 'EOF'
{
  dock = import ./dock.nix;
  finder = import ./finder.nix;
  defaults = import ./defaults.nix;
}
EOF

# Security modules
cat > modules/nixos/security/default.nix << 'EOF'
{
  onepassword = import ./onepassword.nix;
  keybase = import ./keybase.nix;
  keyd = import ./keyd.nix;
  vpn = import ./vpn.nix;
}
EOF

cat > modules/darwin/security/default.nix << 'EOF'
{
  touchid = import ./touchid.nix;
}
EOF

# Development modules
cat > modules/nixos/development/default.nix << 'EOF'
{
  containers = import ./containers.nix;
}
EOF

# Hardware modules
cat > modules/nixos/hardware/default.nix << 'EOF'
{
  bluetooth = import ./bluetooth.nix;
}
EOF

# Shared modules index
cat > modules/shared/default.nix << 'EOF'
{
  users = import ./users.nix;
  locale = import ./locale.nix;
  fonts = import ./fonts.nix;
  development = import ./development.nix;
}
EOF

# Home manager modules
cat > home/modules/default.nix << 'EOF'
{
  # Add reusable home-manager modules here
}
EOF

# Create placeholder overlays
cat > overlays/default.nix << 'EOF'
{ inputs }: {
  # Custom overlays go here
  # Example:
  # custom-packages = final: prev: {
  #   myPackage = prev.callPackage ./packages/my-package { };
  # };
}
EOF

# Create lib helpers
cat > lib/default.nix << 'EOF'
{ inputs, ... }: {
  # Helper functions
  mkHost = import ./mk-host.nix { inherit inputs; };
  # Add other helper functions as needed
}
EOF

echo "✅ Directory structure and index files created!"

# Instructions for manual migration
cat << 'EOF'

🔧 MANUAL MIGRATION STEPS:

1. **Copy the new flake.nix** from the artifacts to replace your current one

2. **Create the modular configuration files** using the provided examples:
   - Copy module files from the shared modules artifact
   - Copy host configurations from the host configs artifact  
   - Copy home manager configs from the home manager artifact

3. **Update your current configurations**:
   
   From your old envy/configuration.nix:
   - Move bluetooth config → modules/nixos/hardware/bluetooth.nix
   - Move hyprland config → modules/nixos/desktop/hyprland.nix
   - Move 1password config → modules/nixos/security/onepassword.nix
   - Move keybase config → modules/nixos/security/keybase.nix
   - Move keyd config → modules/nixos/security/keyd.nix
   - Move mullvad config → modules/nixos/security/vpn.nix
   - Move container config → modules/nixos/development/containers.nix
   
   From your old air/configuration.nix:
   - Move homebrew config → modules/darwin/homebrew.nix
   - Move system defaults → hosts/macbook-m1/system.nix
   - Move touch ID config → modules/darwin/security/touchid.nix

4. **Test each host configuration**:
   ```bash
   # For NixOS (laptop-hp)
   sudo nixos-rebuild switch --flake .#laptop-hp
   
   # For Darwin (macbook-m1)  
   darwin-rebuild switch --flake .#macbook-m1
   ```

5. **Update any missing inputs** in flake.nix:
   - Add neovim-nightly-overlay if you use it
   - Add zen-browser if you use it
   - Update any other custom inputs

6. **Update git configuration** in home/erik/programs/git.nix with your actual email

7. **Clean up old files** once migration is verified:
   ```bash
   rm -rf envy/ air/
   ```

🎯 BENEFITS OF NEW STRUCTURE:

✅ Modular and reusable configurations
✅ Clear separation of concerns  
✅ Easy to add new hosts
✅ Follows community best practices
✅ Better maintainability
✅ Shared configurations between hosts
✅ Platform-specific optimizations

📚 NEXT STEPS:

- Consider adding pre-commit hooks for code quality
- Set up automatic formatting with nixfmt-rfc-style
- Add more reusable modules as your config grows
- Consider using nixos-generators for ISO creation
- Look into secrets management with agenix or sops-nix

EOF

echo "🎉 Migration preparation complete!"
echo "📖 Please follow the manual steps above to complete the migration."
