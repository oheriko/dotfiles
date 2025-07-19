# Chezmoi Templating Crash Course

Quick reference for unlocking Chezmoi's templating superpowers, especially for Nix users.

## When to run what where

### 1. Edit templates (in source)
chezmoi cd
nvim dot_config/zsh/dot_zshrc.tmpl
git add . && git commit -m "update zsh config"

### 2. Apply and test (in normal shell)  
cd ~  # or just Ctrl+D to exit chezmoi cd
chezmoi diff
chezmoi apply
source ~/.zshrc  # test it works

### Better edit templates (in home shell)
chezmoi edit .config/zsh/.zshrc
<!-- Note the escaped git flags -->
chezmoi git add . && chezmoi git commit -- -m "update zsh config"

### These work from anywhere
chezmoi git status
chezmoi git add .  
chezmoi git commit -m "update configs"
chezmoi git push origin main

### Example flow for new template
# 1. Convert existing file to template
chezmoi re-add --template ~/.config/starship/config

# 2. Edit the template (this opens the .tmpl version)
chezmoi edit ~/.config/starship/config

# 3. Test your template
chezmoi execute-template '{{ .chezmoi.hostname }}'  # Quick variable test
chezmoi cat ~/.config/starship/config              # See full rendered output

# 4. Preview changes
chezmoi diff

# 5. Apply when ready
chezmoi apply

## Template Syntax - Go Templates

Chezmoi uses Go's template syntax (similar to Helm):

```bash
# Variables
{{ .variable }}

# Conditionals
{{- if condition }}
content here
{{- else }}
other content
{{- end }}

# Loops
{{- range .items }}
item: {{ . }}
{{- end }}

# Comments (won't appear in output)
{{/* This is a comment */}}

# Whitespace control (the dash removes whitespace)
{{- if true -}}    # Removes whitespace before/after
no extra lines
{{- end -}}
```

## Built-in Variables

```yaml
# System information
{{ .chezmoi.hostname }}          # "laptop-hp" or "macbook-m1"
{{ .chezmoi.os }}               # "linux" or "darwin"
{{ .chezmoi.arch }}             # "amd64" or "arm64"
{{ .chezmoi.username }}         # "erik"
{{ .chezmoi.homeDir }}          # "/home/erik" or "/Users/erik"

# OS details
{{ .chezmoi.kernel.osrelease }} # Linux kernel version
{{ .chezmoi.kernel.version }}   # Full kernel version

# Working directories
{{ .chezmoi.sourceDir }}        # Your chezmoi source directory
{{ .chezmoi.workingTree }}      # Git working tree (if in git)

# Custom variables (from .chezmoi.yaml.tmpl)
{{ .is_macos }}                 # Your custom bool
{{ .is_nixos }}                 # Your custom bool
{{ .pkg_manager }}              # Your custom string
{{ .font_size }}                # Your custom number

# Template functions
{{ eq .chezmoi.os "darwin" }}   # equals comparison
{{ ne .chezmoi.os "linux" }}    # not equals
{{ and .is_macos .is_laptop }}  # logical and
{{ or .is_macos .is_linux }}    # logical or

# String functions
{{ printf "Hello %s" .chezmoi.username }}    # "Hello erik"
{{ .chezmoi.hostname | upper }}              # "LAPTOP-HP"
{{ .chezmoi.homeDir | base }}                # "erik"
```

## Real Examples

### Simple Platform Detection
```bash
{{- if eq .chezmoi.os "darwin" }}
# macOS stuff
export BROWSER="open"
{{- else }}
# Linux stuff  
export BROWSER="firefox"
{{- end }}
```

### Machine-Specific Values
```bash
{{- if eq .chezmoi.hostname "laptop-hp" }}
export JAVA_OPTS="-Xmx8g"  # More RAM on powerful machine
{{- else if eq .chezmoi.hostname "macbook-m1" }}
export JAVA_OPTS="-Xmx4g"  # Less RAM on portable machine
{{- end }}
```

### Custom Variables
```bash
# In .chezmoi.yaml.tmpl
data:
  editor: "{{ if eq .chezmoi.hostname "laptop-hp" }}code{{ else }}nvim{{ end }}"
  
# In any other .tmpl file
export EDITOR="{{ .editor }}"
```

## File Naming Magic

```bash
# Basic patterns
dot_zshrc.tmpl                    # Becomes ~/.zshrc (templated)
private_dot_ssh/config.tmpl       # Becomes ~/.ssh/config (private, templated)
executable_dot_local/bin/script   # Becomes ~/.local/bin/script (executable)

# Platform-specific files
dot_zshrc.darwin.tmpl            # Only on macOS
dot_zshrc.linux.tmpl             # Only on Linux
dot_bashrc.laptop-hp.tmpl        # Only on laptop-hp machine

# Combined attributes
private_executable_dot_local/bin/secret.tmpl  # Private + executable + templated
```

## Daily Commands

```bash
# Check what would change
chezmoi diff

# Preview changes without applying
chezmoi apply --dry-run

# Apply all changes
chezmoi apply

# Apply specific file
chezmoi apply ~/.zshrc

# Edit a template (opens in $EDITOR)
chezmoi edit ~/.zshrc

# Add new file to chezmoi
chezmoi add ~/.config/new-app/config.yml

# See what a template renders to
chezmoi cat ~/.zshrc

# Test template expressions
chezmoi execute-template '{{ .chezmoi.hostname }}'
chezmoi execute-template '{{ if eq .chezmoi.os "darwin" }}macOS{{ else }}Linux{{ end }}'

# Status - see what files are managed
chezmoi status

# Update from git and apply
chezmoi update

# Open chezmoi source directory
chezmoi cd

# Verify everything matches
chezmoi verify

# Debug variables (super useful!)
chezmoi data

# Re-add file after editing outside chezmoi
chezmoi re-add ~/.zshrc
```

## Debugging Templates

```bash
# See all available variables
chezmoi data

# Test a specific template expression
chezmoi execute-template '{{ .chezmoi | toJson }}'

# Check template syntax
chezmoi apply --dry-run

# See what file would be generated
chezmoi cat ~/.zshrc

# Debug specific variable
chezmoi execute-template '{{ .chezmoi.os }}'
```

## Quick Start - Convert Your First File

1. **Back up current file**:
```bash
chezmoi cd
cp dot_config/zsh/dot_zshrc dot_config/zsh/dot_zshrc.backup
```

2. **Rename to template**:
```bash
mv dot_config/zsh/dot_zshrc dot_config/zsh/dot_zshrc.tmpl
```

3. **Add one simple template**:
```bash
# Change this line:
export PATH="$PATH:/Users/erik/.cargo/bin"

# To this:
{{- if eq .chezmoi.os "darwin" }}
export PATH="$PATH:/Users/erik/.cargo/bin"
{{- else }}
export PATH="$PATH:$HOME/.cargo/bin"
{{- end }}
```

4. **Test it**:
```bash
chezmoi cat ~/.config/zsh/.zshrc  # See the rendered output
chezmoi diff                      # See what would change
chezmoi apply --dry-run          # Safe preview
chezmoi apply                     # Apply it!
```

## Best Practices

### Start Small
- Convert one hardcoded value at a time
- Test after each change
- Use `chezmoi diff` and `--dry-run` liberally

### Platform Detection Patterns
```bash
# Standard OS detection
{{- if eq .chezmoi.os "darwin" }}
macOS specific
{{- else if eq .chezmoi.os "linux" }}
Linux specific
{{- end }}

# Machine-specific
{{- if eq .chezmoi.hostname "laptop-hp" }}
Development machine config
{{- else if eq .chezmoi.hostname "macbook-m1" }}
Portable machine config
{{- end }}

# Combined conditions
{{- if and (eq .chezmoi.os "linux") (eq .chezmoi.hostname "laptop-hp") }}
Linux development machine only
{{- end }}
```

### Custom Variables
Create a `.chezmoi.yaml.tmpl` with your own variables:

```yaml
{{- $is_macos := eq .chezmoi.os "darwin" -}}
{{- $is_linux := eq .chezmoi.os "linux" -}}
{{- $is_nixos := and $is_linux (stat "/etc/NIXOS") -}}

data:
  is_macos: {{ $is_macos }}
  is_linux: {{ $is_linux }}
  is_nixos: {{ $is_nixos }}
  
  # Machine-specific settings
  {{- if eq .chezmoi.hostname "laptop-hp" }}
  font_size: 11
  ui_scale: 1.2
  {{- else if eq .chezmoi.hostname "macbook-m1" }}
  font_size: 13
  ui_scale: 1.0
  {{- end }}
  
  # Package manager shortcuts
  {{- if $is_macos }}
  pkg_manager: "brew"
  shell_path: "/opt/homebrew/bin/zsh"
  {{- else if $is_nixos }}
  pkg_manager: "nix"
  shell_path: "/run/current-system/sw/bin/zsh"
  {{- end }}
```

## Nix Integration Patterns

### What to Keep in Nix vs Chezmoi
**Keep in Nix:**
- System packages and services
- Home Manager for package installation
- Development environments

**Move to Chezmoi Templates:**
- Application configuration files
- Shell configurations that vary by platform
- Any config needing conditional logic

**Hybrid (Template Your Nix Files):**
```nix
# In a .nix.tmpl file
{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Core tools (all platforms)
    git
    neovim
    
    {{- if eq .chezmoi.os "darwin" }}
    # macOS specific
    mas
    {{- else }}
    # Linux specific  
    xclip
    {{- end }}
    
    {{- if eq .chezmoi.hostname "laptop-hp" }}
    # Development powerhouse packages
    docker
    kubernetes-helm
    {{- end }}
  ];
}
```

## Common Gotchas

1. **Whitespace matters** - Use `{{-` and `-}}` to control spacing
2. **Test templates** - Always use `chezmoi cat` before applying
3. **Quote strings** - Use quotes in conditionals: `eq .var "string"`
4. **File permissions** - Use `executable_` prefix for scripts
5. **Secrets** - Use `private_` prefix for sensitive files

## Advanced Patterns

### External Commands
```bash
# Run commands in templates
{{ output "hostname" }}
{{ output "git" "config" "user.name" }}
```

### Include Files
```bash
# Include other templates
{{ include "common-aliases.sh" }}
```

### Loops
```bash
{{- range .servers }}
Host {{ .name }}
    HostName {{ .ip }}
{{- end }}
```

Remember: **Start simple, iterate, and test often!** 🚀

