#!/usr/bin/env bash
# ══════════════════════════════════════════════════════════════════════════════
#  Dotfiles Uninstaller — Removes symlinks, restores backups
# ══════════════════════════════════════════════════════════════════════════════

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BOLD='\033[1m'
NC='\033[0m'

info()    { echo -e "\033[0;34m[info]${NC} $1"; }
success() { echo -e "${GREEN}[done]${NC} $1"; }
warn()    { echo -e "${YELLOW}[skip]${NC} $1"; }

echo ""
echo -e "${BOLD}Uninstalling dotfiles symlinks...${NC}"
echo ""

# Remove symlinks (only if they ARE symlinks — don't delete real files)
unlink_if_symlink() {
    local target="$1"
    if [[ -L "$target" ]]; then
        rm -f "$target"
        success "Removed $(basename "$target")"
    elif [[ -e "$target" ]]; then
        warn "$(basename "$target") is not a symlink, leaving it alone"
    fi
}

unlink_if_symlink "$HOME/.config/ghostty"
unlink_if_symlink "$HOME/.config/starship.toml"
unlink_if_symlink "$HOME/.zshrc"
unlink_if_symlink "$HOME/.gitconfig"
unlink_if_symlink "$HOME/.ripgreprc"
unlink_if_symlink "$HOME/.config/lazygit"
unlink_if_symlink "$HOME/.config/atuin/config.toml"
unlink_if_symlink "$HOME/.config/yazi/theme.toml"
unlink_if_symlink "$HOME/.config/gh/config.yml"
unlink_if_symlink "$HOME/.config/mise/config.toml"

# Restore backup if available
LATEST_BACKUP=$(ls -dt "$HOME"/.dotfiles-backup-* 2>/dev/null | head -1)

if [[ -n "$LATEST_BACKUP" ]]; then
    echo ""
    info "Found backup at $LATEST_BACKUP"
    echo -n "  Restore from backup? (y/N) "
    read -r restore

    if [[ "$restore" == "y" || "$restore" == "Y" ]]; then
        for file in "$LATEST_BACKUP"/*; do
            local_name=$(basename "$file")
            case "$local_name" in
                ghostty|lazygit)
                    cp -r "$file" "$HOME/.config/$local_name"
                    ;;
                starship.toml)
                    cp "$file" "$HOME/.config/starship.toml"
                    ;;
                zshrc)
                    cp "$file" "$HOME/.zshrc"
                    ;;
                gitconfig)
                    cp "$file" "$HOME/.gitconfig"
                    ;;
                *)
                    warn "Don't know where to restore $local_name"
                    ;;
            esac
        done
        success "Backup restored"
    fi
fi

echo ""
echo -e "${GREEN}Uninstall complete.${NC} Your .local files were not touched."
echo ""
