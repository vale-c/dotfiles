#!/usr/bin/env bash
# ══════════════════════════════════════════════════════════════════════════════
#  Dotfiles Installer — One command, full terminal setup
#  Usage: git clone <repo> ~/.dotfiles && ~/.dotfiles/install.sh
# ══════════════════════════════════════════════════════════════════════════════

set -euo pipefail

# ─── Colors ──────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

info()    { echo -e "${BLUE}[info]${NC} $1"; }
success() { echo -e "${GREEN}[done]${NC} $1"; }
warn()    { echo -e "${YELLOW}[skip]${NC} $1"; }
error()   { echo -e "${RED}[fail]${NC} $1"; }

# ─── Resolve dotfiles directory ──────────────────────────────────────────────
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d)"

echo ""
echo -e "${BOLD}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}║  Terminal Powerhouse — Catppuccin Mocha Edition     ║${NC}"
echo -e "${BOLD}╚══════════════════════════════════════════════════════╝${NC}"
echo ""

# ─── Step 1: Preflight ──────────────────────────────────────────────────────
info "Running preflight checks..."

if [[ "$(uname)" != "Darwin" ]]; then
    error "This installer is macOS-only."
    exit 1
fi

if ! xcode-select -p &>/dev/null; then
    info "Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "Press any key after Xcode tools finish installing..."
    read -n 1 -s
fi

success "Preflight passed"

# ─── Step 2: Homebrew ────────────────────────────────────────────────────────
info "Checking Homebrew..."

if ! command -v brew &>/dev/null; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    success "Homebrew installed"
else
    success "Homebrew already installed"
fi

# ─── Step 3: Install dependencies ────────────────────────────────────────────
info "Installing tools via Brewfile..."

if brew bundle --file="$DOTFILES/Brewfile"; then
    success "All tools installed"
else
    warn "Some brew packages may have failed — check output above"
fi

# ─── Step 4: Backup existing configs ─────────────────────────────────────────
backup() {
    local target="$1"
    if [[ -e "$target" ]] && [[ ! -L "$target" ]]; then
        mkdir -p "$BACKUP_DIR"
        local backup_path="$BACKUP_DIR/$(basename "$target")"
        cp -r "$target" "$backup_path"
        warn "Backed up $(basename "$target") → $BACKUP_DIR/"
    fi
}

info "Backing up existing configs..."
backup "$HOME/.config/ghostty"
backup "$HOME/.config/starship.toml"
backup "$HOME/.zshrc"
backup "$HOME/.gitconfig"
backup "$HOME/.gitignore_global"
backup "$HOME/.ripgreprc"
backup "$HOME/.config/lazygit"
backup "$HOME/.config/atuin"
backup "$HOME/.config/yazi"
backup "$HOME/.config/gh"
backup "$HOME/.config/mise"

if [[ -d "$BACKUP_DIR" ]]; then
    success "Backups saved to $BACKUP_DIR/"
else
    success "No existing configs to back up"
fi

# ─── Step 5: Create symlinks ─────────────────────────────────────────────────
link() {
    local src="$1"
    local dst="$2"

    # Remove existing (file, symlink, or directory)
    if [[ -L "$dst" ]]; then
        rm -f "$dst"
    elif [[ -e "$dst" ]]; then
        rm -rf "$dst"
    fi

    # Ensure parent directory exists
    mkdir -p "$(dirname "$dst")"

    ln -sf "$src" "$dst"
    success "Linked $(basename "$dst")"
}

info "Creating symlinks..."

# Ghostty (whole directory)
link "$DOTFILES/ghostty"              "$HOME/.config/ghostty"

# Starship
link "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"

# Zsh
link "$DOTFILES/zsh/zshrc"           "$HOME/.zshrc"

# Git
link "$DOTFILES/git/gitconfig"       "$HOME/.gitconfig"
link "$DOTFILES/git/gitignore_global" "$HOME/.gitignore_global"
link "$DOTFILES/git/ripgreprc"       "$HOME/.ripgreprc"

# Lazygit
link "$DOTFILES/lazygit"             "$HOME/.config/lazygit"

# Atuin (just the config file, not the whole dir — atuin stores data there)
mkdir -p "$HOME/.config/atuin"
link "$DOTFILES/atuin/config.toml"   "$HOME/.config/atuin/config.toml"

# Yazi (just the theme, not the whole dir)
mkdir -p "$HOME/.config/yazi"
link "$DOTFILES/yazi/theme.toml"     "$HOME/.config/yazi/theme.toml"

# GitHub CLI (just the config)
mkdir -p "$HOME/.config/gh"
link "$DOTFILES/gh/config.yml"       "$HOME/.config/gh/config.yml"

# Mise
mkdir -p "$HOME/.config/mise"
link "$DOTFILES/mise/config.toml"    "$HOME/.config/mise/config.toml"

# ─── Step 6: Interactive setup ───────────────────────────────────────────────
if [[ ! -f "$HOME/.gitconfig.local" ]]; then
    echo ""
    info "Setting up git identity..."
    echo -n "  Your name: "
    read -r git_name
    echo -n "  Your email: "
    read -r git_email

    cat > "$HOME/.gitconfig.local" <<EOF
[user]
	name = $git_name
	email = $git_email
EOF
    success "Created ~/.gitconfig.local"
else
    warn "~/.gitconfig.local already exists"
fi

if [[ ! -f "$HOME/.zshrc.local" ]]; then
    cp "$DOTFILES/zsh/zshrc.local.example" "$HOME/.zshrc.local"
    success "Created ~/.zshrc.local from template"
else
    warn "~/.zshrc.local already exists"
fi

# ─── Step 7: Post-install ────────────────────────────────────────────────────
info "Running post-install steps..."

# Build bat theme cache
if command -v bat &>/dev/null; then
    bat cache --build &>/dev/null
    success "bat theme cache built"
fi

# Install mise tool versions
if command -v mise &>/dev/null; then
    info "Installing mise tool versions (node, python)..."
    mise install --yes
    success "mise tools installed"
fi

# Set default shell to zsh if needed
if [[ "$SHELL" != */zsh ]]; then
    info "Setting default shell to zsh..."
    chsh -s "$(which zsh)"
    success "Default shell set to zsh"
fi

# ─── Done ────────────────────────────────────────────────────────────────────
echo ""
echo -e "${BOLD}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}║  Installation complete!                             ║${NC}"
echo -e "${BOLD}╚══════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "  ${GREEN}→${NC} Restart your terminal or run: ${BOLD}exec zsh${NC}"
echo -e "  ${GREEN}→${NC} Optional: run ${BOLD}./macos.sh${NC} for power-user macOS defaults"
echo -e "  ${GREEN}→${NC} Edit ${BOLD}~/.zshrc.local${NC} for machine-specific overrides"
echo -e "  ${GREEN}→${NC} Edit ${BOLD}~/.gitconfig.local${NC} for git identity/signing"
echo ""
