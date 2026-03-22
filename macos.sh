#!/usr/bin/env bash
# ══════════════════════════════════════════════════════════════════════════════
#  macOS Defaults — Power-user system preferences
#  Run once on a new machine. Requires logout to take full effect.
# ══════════════════════════════════════════════════════════════════════════════

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BOLD='\033[1m'
NC='\033[0m'

success() { echo -e "${GREEN}[done]${NC} $1"; }

echo ""
echo -e "${BOLD}Applying macOS power-user defaults...${NC}"
echo ""

# ─── Keyboard ────────────────────────────────────────────────────────────────
# Blazing fast key repeat (essential for terminal/vim)
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10
success "Fast key repeat (1ms repeat, 10ms delay)"

# Disable press-and-hold for keys (gives you key repeat everywhere)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
success "Disabled press-and-hold (key repeat works in all apps)"

# Disable smart quotes and dashes (breaks code pasting)
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
success "Disabled smart quotes and dashes"

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
success "Disabled auto-correct"

# Disable auto-capitalize
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
success "Disabled auto-capitalize"

# ─── Dock ────────────────────────────────────────────────────────────────────
# Auto-hide the Dock
defaults write com.apple.dock autohide -bool true
success "Dock auto-hide enabled"

# Remove the auto-hide delay
defaults write com.apple.dock autohide-delay -float 0
success "Dock show delay removed"

# Fast Dock animation
defaults write com.apple.dock autohide-time-modifier -float 0.15
success "Dock animation speed: 0.15s"

# Minimize windows to their application icon
defaults write com.apple.dock minimize-to-application -bool true
success "Minimize to app icon"

# Don't show recent applications
defaults write com.apple.dock show-recents -bool false
success "Hidden recent apps in Dock"

# ─── Finder ──────────────────────────────────────────────────────────────────
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true
success "Finder shows hidden files"

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true
success "Finder path bar visible"

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
success "Finder status bar visible"

# Full POSIX path in title bar
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
success "Finder shows full path in title"

# Default to list view
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
success "Finder defaults to list view"

# Search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
success "Finder searches current folder by default"

# ─── Screenshots ─────────────────────────────────────────────────────────────
# Save screenshots to ~/Screenshots
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"
success "Screenshots save to ~/Screenshots"

# Save as PNG
defaults write com.apple.screencapture type -string "png"
success "Screenshots format: PNG"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true
success "Screenshot shadows disabled"

# ─── Misc ────────────────────────────────────────────────────────────────────
# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
success "Expanded save dialogs by default"

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
success "Expanded print dialogs by default"

# ─── Apply changes ───────────────────────────────────────────────────────────
echo ""
echo -e "${YELLOW}Restarting Dock and Finder...${NC}"
killall Dock 2>/dev/null || true
killall Finder 2>/dev/null || true

echo ""
echo -e "${BOLD}macOS defaults applied!${NC}"
echo -e "${YELLOW}Some changes require logout/restart to take effect.${NC}"
echo ""
