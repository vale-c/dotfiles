# Dotfiles Rewrite — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the old dotfiles repo with a complete, one-command macOS terminal setup: Ghostty + Catppuccin Mocha + modern CLI toolchain.

**Architecture:** Symlink-based dotfiles repo. Each tool gets its own folder. `install.sh` symlinks everything to `~/.config/` or `~/`, backs up existing configs, installs deps via Brewfile, and interactively sets up `.local` override files. macOS-only.

**Tech Stack:** Ghostty, zsh + zinit, starship, bat, eza, fd, fzf, zoxide, atuin, delta, lazygit, yazi, mise, gh, ripgrep

---

## File Structure

```
dotfiles/
├── ghostty/
│   ├── config                      # Main Ghostty config (Catppuccin Mocha, Monaspace, bloom shader)
│   ├── themes/
│   │   └── catppuccin-mocha        # Custom 16-color theme
│   ├── shaders/                    # 28 background shaders (copied from current setup)
│   │   ├── bloom.glsl
│   │   └── ...
│   └── cursor-shaders/             # 7 cursor shaders (copied from current setup)
│       ├── ripple_cursor.glsl
│       └── ...
├── starship/
│   └── starship.toml               # Catppuccin Mocha prompt with palette
├── zsh/
│   ├── zshrc                       # Full zsh config (mise, yazi, you-should-use, eza colors)
│   └── zshrc.local.example         # Template for machine-specific overrides
├── git/
│   ├── gitconfig                   # Git config with delta Catppuccin (no personal email)
│   ├── gitconfig.local.example     # Template for name/email/signing
│   └── ripgreprc                   # Smart defaults for rg
├── lazygit/
│   └── config.yml                  # Catppuccin-themed lazygit
├── atuin/
│   └── config.toml                 # Smart history with Catppuccin theme
├── yazi/
│   └── theme.toml                  # Catppuccin Mocha yazi theme
├── gh/
│   └── config.yml                  # GitHub CLI aliases
├── mise/
│   └── config.toml                 # Default tool versions (node lts, python latest)
├── install.sh                      # One-command setup
├── uninstall.sh                    # Clean removal
├── macos.sh                        # macOS system defaults
├── Brewfile                        # All CLI dependencies
├── README.md                       # Setup guide
└── .gitignore                      # Ignore *.local, .DS_Store, etc.
```

---

### Task 1: Clean the repo and set up skeleton

**Files:**
- Delete: `nvim/`, `scripts/`, `tmux/`, `zsh/`, `init.lua`, `lazy-lock.json`, `terminal-cheatsheet.html`
- Create: `.gitignore`
- Create: `Brewfile`

- [ ] **Step 1: Remove old files, keep .git**

```bash
cd ~/Desktop/CODING/dotfiles
git rm -r nvim/ scripts/ tmux/ zsh/ init.lua lazy-lock.json terminal-cheatsheet.html README.md
rm -f .DS_Store
```

- [ ] **Step 2: Create .gitignore**

```gitignore
.DS_Store
*.local
*.local.md
.zshrc.local
.gitconfig.local
```

- [ ] **Step 3: Create Brewfile**

```ruby
# Terminal
cask "ghostty"
cask "font-monaspace"
cask "font-fira-code"

# Modern CLI tools
brew "bat"
brew "eza"
brew "fd"
brew "fzf"
brew "ripgrep"
brew "zoxide"
brew "atuin"
brew "git-delta"
brew "starship"
brew "lazygit"
brew "neovim"
brew "yazi"
brew "mise"
brew "gh"
brew "btop"
```

- [ ] **Step 4: Create directory skeleton**

```bash
mkdir -p ghostty/themes ghostty/shaders ghostty/cursor-shaders
mkdir -p starship zsh git lazygit atuin yazi gh mise
```

- [ ] **Step 5: Commit**

```bash
git add -A
git commit -m "chore: clean old dotfiles and set up new skeleton"
```

---

### Task 2: Ghostty config + theme + shaders

**Files:**
- Create: `ghostty/config`
- Create: `ghostty/themes/catppuccin-mocha`
- Copy: `ghostty/shaders/*.glsl` (from `~/.config/ghostty/shaders/`)
- Copy: `ghostty/cursor-shaders/*.glsl` (from `~/.config/ghostty/cursor-shaders/`)

- [ ] **Step 1: Copy Ghostty config from current setup**

```bash
cp ~/.config/ghostty/config ghostty/config
cp ~/.config/ghostty/themes/catppuccin-mocha ghostty/themes/catppuccin-mocha
```

- [ ] **Step 2: Copy all shaders**

```bash
cp ~/.config/ghostty/shaders/*.glsl ghostty/shaders/
cp ~/.config/ghostty/cursor-shaders/*.glsl ghostty/cursor-shaders/
```

Note: Do NOT copy `shaders/theme` (that's a Ghostty-generated file), `shaders/Readme.md`, or `cursor-shaders/README.md`.

- [ ] **Step 3: Commit**

```bash
git add ghostty/
git commit -m "feat: add Ghostty config with Catppuccin Mocha theme and shaders"
```

---

### Task 3: Starship config

**Files:**
- Create: `starship/starship.toml`

- [ ] **Step 1: Copy starship config from current setup**

```bash
cp ~/.config/starship.toml starship/starship.toml
```

Already has Catppuccin Mocha palette from earlier work.

- [ ] **Step 2: Commit**

```bash
git add starship/
git commit -m "feat: add Catppuccin Mocha starship prompt config"
```

---

### Task 4: Git config + ripgreprc

**Files:**
- Create: `git/gitconfig` (sanitized — no personal email)
- Create: `git/gitconfig.local.example`
- Create: `git/ripgreprc`

- [ ] **Step 1: Create gitconfig (sanitized)**

Copy from `~/.gitconfig` but replace the `[user]` section with an include:

```gitconfig
[include]
    path = ~/.gitconfig.local

[init]
    defaultBranch = main
# ... rest of current gitconfig ...
```

- [ ] **Step 2: Create gitconfig.local.example**

```gitconfig
[user]
    name = Your Name
    email = your@email.com
    # signingkey = YOUR_GPG_KEY

# [commit]
#     gpgsign = true
```

- [ ] **Step 3: Create ripgreprc**

```
--smart-case
--hidden
--glob=!.git/
--glob=!node_modules/
--glob=!.next/
--glob=!dist/
--glob=!build/
--glob=!*.min.js
--glob=!*.min.css
--glob=!package-lock.json
--glob=!yarn.lock
--glob=!bun.lockb
--glob=!pnpm-lock.yaml
```

- [ ] **Step 4: Commit**

```bash
git add git/
git commit -m "feat: add git config with Catppuccin delta and ripgreprc"
```

---

### Task 5: Lazygit + Atuin configs

**Files:**
- Create: `lazygit/config.yml`
- Create: `atuin/config.toml`

- [ ] **Step 1: Copy lazygit config**

```bash
cp ~/.config/lazygit/config.yml lazygit/config.yml
```

- [ ] **Step 2: Copy atuin config**

```bash
cp ~/.config/atuin/config.toml atuin/config.toml
```

- [ ] **Step 3: Commit**

```bash
git add lazygit/ atuin/
git commit -m "feat: add Catppuccin lazygit and atuin configs"
```

---

### Task 6: Yazi + gh + mise configs

**Files:**
- Create: `yazi/theme.toml`
- Create: `gh/config.yml`
- Create: `mise/config.toml`

- [ ] **Step 1: Create yazi Catppuccin Mocha theme**

Download/write the official Catppuccin Mocha yazi theme. This is the `theme.toml` from the catppuccin/yazi repo.

- [ ] **Step 2: Create gh config with aliases**

```yaml
aliases:
  co: pr checkout
  mine: pr list --author=@me
  rv: pr list --search "review-requested:@me"
  dash: repo view --web
```

- [ ] **Step 3: Create mise config**

```toml
[tools]
node = "lts"
python = "latest"
# ruby = "latest"
# go = "latest"
```

- [ ] **Step 4: Commit**

```bash
git add yazi/ gh/ mise/
git commit -m "feat: add yazi theme, gh aliases, and mise defaults"
```

---

### Task 7: Zshrc rewrite

**Files:**
- Create: `zsh/zshrc`
- Create: `zsh/zshrc.local.example`

- [ ] **Step 1: Create the new zshrc**

Based on current `~/.zshrc` with these changes:
- Replace `fnm` block with `eval "$(mise activate zsh)"`
- Remove `rbenv` lazy-load block
- Add zinit plugin: `zsh-you-should-use`
- Add `EZA_COLORS` for Catppuccin Mocha
- Add `RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"`
- Add yazi shell integration (`y` function that cds on quit)
- Add `[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"` at end
- Remove `CLAUDE_CODE_MAX_OUTPUT_TOKENS` (goes in .local)

- [ ] **Step 2: Create zshrc.local.example**

```bash
# Machine-specific overrides — this file is gitignored
# Copy to ~/.zshrc.local and customize

# Git credentials (if not using gitconfig.local)
# export GIT_AUTHOR_EMAIL="your@email.com"

# Claude Code
# export CLAUDE_CODE_MAX_OUTPUT_TOKENS=32000

# Extra PATH entries
# export PATH="$HOME/custom/bin:$PATH"

# Work-specific aliases
# alias vpn="networksetup -connectpppoeservice 'Work VPN'"
```

- [ ] **Step 3: Commit**

```bash
git add zsh/
git commit -m "feat: add zshrc with mise, yazi, Catppuccin eza, and you-should-use"
```

---

### Task 8: Install script

**Files:**
- Create: `install.sh`

- [ ] **Step 1: Write install.sh**

The script does (in order):
1. Preflight: verify macOS, install Xcode CLI tools if missing
2. Install/update Homebrew
3. `brew bundle --file=Brewfile`
4. Backup existing configs to `~/.dotfiles-backup-YYYYMMDD/`
5. Symlink map:
   - `ghostty/` → `~/.config/ghostty/` (whole directory)
   - `starship/starship.toml` → `~/.config/starship.toml`
   - `zsh/zshrc` → `~/.zshrc`
   - `git/gitconfig` → `~/.gitconfig`
   - `git/ripgreprc` → `~/.ripgreprc`
   - `lazygit/` → `~/.config/lazygit/`
   - `atuin/config.toml` → `~/.config/atuin/config.toml`
   - `yazi/theme.toml` → `~/.config/yazi/theme.toml`
   - `gh/config.yml` → `~/.config/gh/config.yml`
   - `mise/config.toml` → `~/.config/mise/config.toml`
6. Interactive: prompt for git name/email → write `~/.gitconfig.local`
7. Post-install: `bat cache --build`, print summary

Key behaviors:
- Idempotent (skip existing symlinks)
- Color-coded output (green/yellow/red)
- Non-destructive (always backup first)
- Each step independent (one failure doesn't block the rest)

- [ ] **Step 2: Make executable**

```bash
chmod +x install.sh
```

- [ ] **Step 3: Commit**

```bash
git add install.sh
git commit -m "feat: add one-command install script"
```

---

### Task 9: Uninstall script + macOS defaults

**Files:**
- Create: `uninstall.sh`
- Create: `macos.sh`

- [ ] **Step 1: Write uninstall.sh**

Removes all symlinks created by install.sh. Restores from backup if available. Does NOT uninstall Homebrew or tools.

- [ ] **Step 2: Write macos.sh**

macOS defaults:
- Fast key repeat: `defaults write NSGlobalDomain KeyRepeat -int 1`
- Short delay: `defaults write NSGlobalDomain InitialKeyRepeat -int 10`
- Disable press-and-hold: `defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false`
- Dock autohide: `defaults write com.apple.dock autohide -bool true`
- Dock instant show: `defaults write com.apple.dock autohide-delay -float 0`
- Dock fast animation: `defaults write com.apple.dock autohide-time-modifier -float 0.15`
- Finder show hidden: `defaults write com.apple.finder AppleShowAllFiles -bool true`
- Finder path bar: `defaults write com.apple.finder ShowPathbar -bool true`
- Finder full path title: `defaults write com.apple.finder _FXShowPosixPathInTitle -bool true`
- Disable smart quotes: `defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false`
- Disable smart dashes: `defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false`
- Disable auto-correct: `defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false`
- Print warning that logout is needed

- [ ] **Step 3: Make both executable and commit**

```bash
chmod +x uninstall.sh macos.sh
git add uninstall.sh macos.sh
git commit -m "feat: add uninstall script and macOS defaults"
```

---

### Task 10: README

**Files:**
- Create: `README.md`

- [ ] **Step 1: Write README**

Sections:
1. Title + one-line description + screenshot placeholder
2. "What's Inside" — table of tool/purpose/replaces
3. "Quick Start" — three commands (clone, install, restart)
4. "What the Install Does" — numbered list
5. "Customization" — `.local` files, shader swapping, font options
6. "Ghostty Keybinds" — table
7. "Shell Functions" — table (gbr, glog, fe, fcd, zz, week, note, y)
8. "Git Aliases" — table
9. "macOS Defaults" — what macos.sh does
10. "Acknowledgments" — Catppuccin, Monaspace, shader authors

- [ ] **Step 2: Commit**

```bash
git add README.md
git commit -m "docs: add README with setup guide and reference tables"
```

---

### Task 11: Wire up live config + push

**Files:**
- Modify: none (symlink switch)

- [ ] **Step 1: Run install.sh on this machine**

This replaces the current configs with symlinks into the repo. Existing configs get backed up.

```bash
cd ~/Desktop/CODING/dotfiles
./install.sh
```

- [ ] **Step 2: Verify everything works**

```bash
exec zsh          # reload shell
starship --version # prompt works
bat --list-themes | grep Catppuccin  # bat theme
eza --icons       # eza with catppuccin colors
mise ls           # mise active
y                 # yazi opens
```

- [ ] **Step 3: Push to GitHub**

```bash
git push origin main --force
```

Force push since we're replacing the entire repo content.

- [ ] **Step 4: Commit any fixes discovered during testing**

```bash
git add -A
git commit -m "fix: post-install adjustments"
git push
```
