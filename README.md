# dotfiles

One-command terminal setup for macOS. Catppuccin Mocha everything.

<!-- TODO: Add screenshot -->
<!-- ![Terminal Screenshot](screenshot.png) -->

## What's Inside

| Tool | Purpose | Replaces |
|------|---------|----------|
| [Ghostty](https://ghostty.org) | Terminal emulator with GPU shaders | iTerm2, Terminal.app |
| [Starship](https://starship.rs) | Cross-shell prompt | Oh My Zsh themes, Powerlevel10k |
| [zinit](https://github.com/zdharma-continuum/zinit) | Plugin manager (turbo mode) | Oh My Zsh, antigen |
| [bat](https://github.com/sharkdp/bat) | `cat` with syntax highlighting | cat |
| [eza](https://github.com/eza-community/eza) | `ls` with icons & git status | ls, exa |
| [fd](https://github.com/sharkdp/fd) | `find` but fast & user-friendly | find |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder for everything | — |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | `grep` but blazing fast | grep, ag |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smart `cd` that learns | z, autojump |
| [atuin](https://atuin.sh) | Shell history with search & sync | Ctrl+R |
| [delta](https://github.com/dandavison/delta) | Beautiful git diffs | diff, diff-so-fancy |
| [lazygit](https://github.com/jesseduffield/lazygit) | Terminal UI for git | — |
| [yazi](https://yazi-rs.github.io) | Terminal file manager | ranger, lf |
| [mise](https://mise.jdx.dev) | Universal version manager | fnm, nvm, rbenv, pyenv |
| [gh](https://cli.github.com) | GitHub CLI | hub |
| [Monaspace](https://monaspace.githubnext.com) | Font with texture healing | Fira Code |

**Theme:** [Catppuccin Mocha](https://catppuccin.com) across every tool.

## Quick Start

```bash
git clone https://github.com/vale-c/dotfiles.git ~/.dotfiles
~/.dotfiles/install.sh
```

Then restart your terminal. That's it.

## What the Install Does

1. Installs [Homebrew](https://brew.sh) (if missing)
2. Installs all tools via `Brewfile`
3. Backs up your existing configs to `~/.dotfiles-backup-YYYYMMDD/`
4. Symlinks all configs to the right locations
5. Prompts for your git name/email (stored in `~/.gitconfig.local`)
6. Builds bat theme cache
7. Installs Node LTS and Python via mise

**Safe to run multiple times** — idempotent and non-destructive.

## Optional: macOS Defaults

```bash
~/.dotfiles/macos.sh
```

Power-user system preferences:
- Blazing fast key repeat (essential for terminal/vim)
- No press-and-hold (get key repeat everywhere)
- Instant Dock auto-hide
- Finder: hidden files, path bar, full POSIX path title
- Disabled smart quotes, dashes, and auto-correct
- Screenshots to `~/Screenshots` as PNG

Requires logout to take full effect.

## Customization

### Machine-specific overrides

Two `.local` files are gitignored and never overwritten:

- **`~/.zshrc.local`** — extra aliases, PATH entries, env vars (e.g., `CLAUDE_CODE_MAX_OUTPUT_TOKENS`)
- **`~/.gitconfig.local`** — your name, email, GPG signing key

### Swap the Ghostty shader

Edit `ghostty/config` and change:

```
custom-shader = shaders/bloom.glsl
```

Available shaders (33 included):

| Shader | Vibe |
|--------|------|
| `bloom.glsl` | Subtle glow on bright text (default) |
| `crt.glsl` | Retro CRT scanlines |
| `gradient-background.glsl` | Animated gradient |
| `starfield.glsl` | Stars behind your terminal |
| `matrix-hallway.glsl` | Matrix rain |
| `underwater.glsl` | Underwater caustics |

### Swap the font

Edit `ghostty/config` and change `font-family`. Monaspace Neon is the default, Fira Code is the fallback (both installed via Brewfile).

## Ghostty Keybinds

| Shortcut | Action |
|----------|--------|
| `Cmd + \`` | Drop-down quake terminal |
| `Cmd + D` | Split right |
| `Cmd + Shift + D` | Split down |
| `Cmd + Alt + arrows` | Navigate splits |
| `Cmd + Shift + Enter` | Zoom split |
| `Cmd + =/-/0` | Font size |

## Shell Functions

| Command | What it does |
|---------|-------------|
| `gbr` | Fuzzy git branch switcher with commit preview |
| `glog` | Interactive git log — pick commit, see diff, copies hash |
| `fe` | Fuzzy find & open any file in `$EDITOR` |
| `fcd` | Fuzzy cd into any subdirectory |
| `zz` | Jump to any zoxide-tracked project with fzf |
| `y` | Yazi file manager (cd into directory on quit) |
| `week` | Git work summary for the past week |
| `today` | Git commits from today |
| `note "text"` | Quick scratchpad (or `note` to open today's file) |
| `mkcd dir` | mkdir + cd in one |
| `extract file` | Extract any archive format |
| `killport 3000` | Kill process on a port |
| `serve` | Quick HTTP server (default port 8000) |

## Git Aliases

| Alias | Command |
|-------|---------|
| `gs` | `git status -sb` |
| `gl` | `git log --oneline --graph --decorate -20` |
| `gd` / `gds` | `git diff` / `git diff --staged` |
| `ga` / `gaa` | `git add` / `git add .` |
| `gc` / `gcm` | `git commit` / `git commit -m` |
| `gco` / `gcb` | `git checkout` / `git checkout -b` |
| `gp` | `git pull --rebase` |
| `gpsh` / `gpshf` | `git push` / `git push --force-with-lease` |
| `lg` | `lazygit` |
| `gwip` | Quick WIP commit |

## GitHub CLI Aliases

| Alias | Command |
|-------|---------|
| `gh mine` | Your open PRs |
| `gh rv` | PRs requesting your review |
| `gh co 123` | Checkout PR branch |
| `gh dash` | Open repo in browser |
| `gh prc` | Create PR in browser |
| `gh runs` | Recent CI runs |

## Uninstall

```bash
~/.dotfiles/uninstall.sh
```

Removes symlinks and optionally restores your backed-up configs. Does not uninstall Homebrew or tools.

## Acknowledgments

- [Catppuccin](https://catppuccin.com) — the theme that ties everything together
- [Monaspace](https://monaspace.githubnext.com) — GitHub's monospace font family
- [Ghostty Shaders](https://github.com/search?q=ghostty+shaders) — community shader collection
