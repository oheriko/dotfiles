# Nix Configuration Refactor Plan

## Current Issues Identified

1. **Naming**: Using personal names ("air", "envy") instead of descriptive hostnames
2. **Structure**: Flat directory structure without clear separation of concerns
3. **Duplication**: Repeated configurations between systems
4. **Missing Modularity**: No shared modules or common configurations

## Proposed New Structure

```
├── flake.nix
├── flake.lock
├── lib/
│   └── default.nix                    # Helper functions
├── modules/
│   ├── nixos/
│   │   ├── desktop/
│   │   │   ├── hyprland.nix
│   │   │   ├── fonts.nix
│   │   │   └── audio.nix
│   │   ├── development/
│   │   │   ├── containers.nix
│   │   │   └── tools.nix
│   │   ├── security/
│   │   │   ├── keybase.nix
│   │   │   └── vpn.nix
│   │   └── hardware/
│   │       └── bluetooth.nix
│   ├── darwin/
│   │   ├── desktop/
│   │   │   ├── dock.nix
│   │   │   ├── finder.nix
│   │   │   └── trackpad.nix
│   │   ├── security/
│   │   │   └── touchid.nix
│   │   └── homebrew.nix
│   └── shared/
│       ├── users.nix
│       ├── locale.nix
│       └── fonts.nix
├── hosts/
│   ├── laptop-hp/                     # Previously "envy"
│   │   ├── default.nix
│   │   ├── hardware.nix
│   │   └── home.nix
│   └── macbook-m1/                    # Previously "air"
│       ├── default.nix
│       ├── system.nix
│       └── home.nix
├── home/
│   ├── erik/
│   │   ├── default.nix
│   │   ├── packages.nix
│   │   ├── programs/
│   │   │   ├── git.nix
│   │   │   ├── shell.nix
│   │   │   └── editors.nix
│   │   └── desktop/
│   │       ├── hyprland.nix
│   │       └── waybar.nix
│   └── shared/
│       ├── packages.nix
│       └── programs.nix
└── overlays/
    └── default.nix
```

## Key Improvements

### 1. **Better Naming Convention**
- `envy` → `laptop-hp` (descriptive of hardware)
- `air` → `macbook-m1` (descriptive of hardware)

### 2. **Modular Architecture**
- **modules/**: Reusable configuration modules
- **hosts/**: Host-specific configurations
- **home/**: Home Manager configurations
- **lib/**: Helper functions and utilities

### 3. **Shared Configurations**
- Common user settings
- Shared package lists
- Cross-platform compatible modules

### 4. **Platform-Specific Modules**
- NixOS-specific configurations in `modules/nixos/`
- Darwin-specific configurations in `modules/darwin/`
- Shared configurations in `modules/shared/`

### 5. **Home Manager Organization**
- User-specific configurations
- Program-specific modules
- Desktop environment configurations

## Implementation Benefits

1. **Maintainability**: Easier to update and maintain configurations
2. **Reusability**: Modules can be shared across hosts
3. **Clarity**: Clear separation between different types of configurations
4. **Scalability**: Easy to add new hosts or users
5. **Best Practices**: Follows modern Nix community standards

## Migration Strategy

1. Create new directory structure
2. Extract shared configurations into modules
3. Migrate host-specific configs to new structure
4. Update flake.nix with new paths
5. Test each host configuration independently
6. Remove old files once migration is verified

This structure follows the patterns used by popular Nix configurations like nixos-config templates and community best practices as of 2025.
