# dotfiles

One-command terminal setup for macOS. Catppuccin Mocha everything.

<!-- TODO: Add screenshot -->
<!-- ![Terminal Screenshot](screenshot.png) -->

---

## Table of Contents

- [What Are Dotfiles?](#what-are-dotfiles)
- [What You Get](#what-you-get)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Your First 10 Minutes](#your-first-10-minutes)
- [Understanding the Tools](#understanding-the-tools)
  - [Ghostty — Your Terminal](#ghostty--your-terminal)
  - [Starship — Your Prompt](#starship--your-prompt)
  - [Zsh Plugins — Smarter Shell](#zsh-plugins--smarter-shell)
  - [Modern CLI Replacements](#modern-cli-replacements)
  - [Git Superpowers](#git-superpowers)
  - [Fuzzy Finding Everything](#fuzzy-finding-everything)
  - [File Management with Yazi](#file-management-with-yazi)
  - [Version Management with Mise](#version-management-with-mise)
  - [GitHub CLI](#github-cli)
- [Shell Aliases Cheat Sheet](#shell-aliases-cheat-sheet)
- [Power Functions](#power-functions)
- [Customization](#customization)
  - [Machine-Specific Overrides](#machine-specific-overrides)
  - [Swap the Theme](#swap-the-theme)
  - [Swap the Font](#swap-the-font)
  - [Add a Shader](#add-a-shader)
  - [Add Your Own Aliases](#add-your-own-aliases)
- [Optional: macOS System Defaults](#optional-macos-system-defaults)
- [How It All Works](#how-it-all-works)
- [Updating](#updating)
- [Uninstalling](#uninstalling)
- [Troubleshooting](#troubleshooting)
- [Acknowledgments](#acknowledgments)

---

## What Are Dotfiles?

On macOS (and Linux), programs store their settings in hidden files that start with a dot — like `.zshrc`, `.gitconfig`, or files inside `~/.config/`. These are called "dotfiles."

This repository collects all of those config files in one place so you can:

- **Set up a new Mac in minutes** instead of hours of manual tweaking
- **Keep your configs under version control** so you never lose them
- **Share a consistent environment** across multiple machines

The installer creates [symlinks](https://en.wikipedia.org/wiki/Symbolic_link) (shortcuts) from where each program expects its config file to the files in this repo. That means when you edit a file in this repo, the changes take effect immediately — and you can commit them to git.

---

## What You Get

| Tool | What It Does | What It Replaces |
|------|-------------|------------------|
| [Ghostty](https://ghostty.org) | GPU-accelerated terminal with shaders | iTerm2, Terminal.app |
| [Starship](https://starship.rs) | Fast, minimal prompt with git info | Oh My Zsh themes, Powerlevel10k |
| [zinit](https://github.com/zdharma-continuum/zinit) | Plugin manager with lazy loading | Oh My Zsh, antigen |
| [bat](https://github.com/sharkdp/bat) | `cat` with syntax highlighting & line numbers | `cat` |
| [eza](https://github.com/eza-community/eza) | `ls` with icons, colors & git status | `ls`, `exa` |
| [fd](https://github.com/sharkdp/fd) | `find` but simpler and faster | `find` |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder — search anything interactively | — |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | `grep` but 10-100x faster | `grep`, `ag` |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smart `cd` that remembers your directories | `z`, `autojump` |
| [atuin](https://atuin.sh) | Searchable shell history with optional sync | `Ctrl+R` default |
| [delta](https://github.com/dandavison/delta) | Beautiful side-by-side git diffs | `diff`, `diff-so-fancy` |
| [lazygit](https://github.com/jesseduffield/lazygit) | Full git UI in the terminal | — |
| [yazi](https://yazi-rs.github.io) | Terminal file manager with image previews | `ranger`, `lf` |
| [mise](https://mise.jdx.dev) | Manages Node, Python, Ruby, Go versions | `nvm`, `pyenv`, `rbenv` |
| [gh](https://cli.github.com) | GitHub from the terminal | `hub` |
| [Monaspace](https://monaspace.githubnext.com) | Coding font with ligatures & texture healing | Fira Code |

**Theme:** [Catppuccin Mocha](https://catppuccin.com) — a soothing dark palette applied consistently across every tool.

---

## Prerequisites

- **macOS** (Apple Silicon or Intel)
- **A terminal** (Terminal.app is fine — Ghostty will be installed for you)
- **An internet connection** (the installer downloads tools via Homebrew)

That's it. The installer handles everything else, including Xcode Command Line Tools and Homebrew.

---

## Installation

### 1. Clone the repo

```bash
git clone https://github.com/vale-c/dotfiles.git ~/.dotfiles
```

> This puts the dotfiles in `~/.dotfiles` (a hidden folder in your home directory). You can clone it anywhere, but `~/.dotfiles` is the convention.

### 2. Run the installer

```bash
~/.dotfiles/install.sh
```

The installer will:

1. Check that you're on macOS and install Xcode Command Line Tools if needed
2. Install [Homebrew](https://brew.sh) (the macOS package manager) if you don't have it
3. Install all the tools listed above via Homebrew
4. **Back up your existing configs** to `~/.dotfiles-backup-YYYYMMDD/` (nothing is lost)
5. Create symlinks from each tool's config location to the files in this repo
6. Ask for your **git name and email** (stored privately in `~/.gitconfig.local`)
7. Install Node.js LTS and Python via mise
8. Set zsh as your default shell if it isn't already

**Safe to run multiple times.** The installer is idempotent — running it again won't break anything or duplicate configs.

### 3. Restart your terminal

Close and reopen your terminal, or run:

```bash
exec zsh
```

### 4. Open Ghostty

Ghostty was installed by Homebrew. Open it from Spotlight (`Cmd + Space`, type "Ghostty") or your Applications folder. This is your new terminal — everything is pre-configured.

---

## Your First 10 Minutes

Here are some things to try right away to see what's changed:

### See the new `ls`

```bash
ls              # icons, colored by type, directories first
ll              # detailed view with permissions, git status
lt              # tree view (2 levels deep)
```

### See the new `cat`

```bash
cat ~/.zshrc    # syntax highlighted with line numbers
```

### Try fuzzy finding

```bash
# Press Ctrl+T in the terminal to fuzzy-search files
# Press Ctrl+R to search your shell history (via atuin)
# Press Alt+C to fuzzy-cd into a directory
```

### Check your git setup

```bash
gs              # short git status
gl              # compact git log with graph
gd              # pretty side-by-side diff (powered by delta)
```

### Try the quake terminal

Press **Cmd + `** (backtick) anywhere on your Mac. A terminal drops down from the top of your screen. Press it again to hide it. This works even when Ghostty isn't focused.

### Open the file manager

```bash
y               # opens yazi — navigate with arrows, press Enter to open, q to quit
```

### Jump to a recent directory

```bash
cd ~/some/project       # visit a directory once...
cd ~                    # go somewhere else...
cd some                 # zoxide remembers — it'll jump to ~/some/project
```

---

## Understanding the Tools

### Ghostty — Your Terminal

[Ghostty](https://ghostty.org) is a modern, GPU-accelerated terminal emulator. It's fast, configurable, and renders text beautifully.

**What's configured:**

- **Theme:** Catppuccin Mocha (dark, easy on the eyes)
- **Font:** Monaspace Neon at size 14 with ligatures (e.g., `=>` renders as `⇒`)
- **Background:** Slightly transparent (92% opacity) with blur
- **Cursor:** Blinking bar, hides when you type
- **Scrollback:** 100,000 lines

**Key shortcuts:**

| Shortcut | Action |
|----------|--------|
| `Cmd + `` ` | Drop-down quake terminal (works globally) |
| `Cmd + D` | Split pane to the right |
| `Cmd + Shift + D` | Split pane downward |
| `Cmd + Alt + arrows` | Navigate between splits |
| `Cmd + Shift + Enter` | Zoom/unzoom a split |
| `Cmd + =` / `Cmd + -` | Increase / decrease font size |
| `Cmd + 0` | Reset font size |

**Config location:** `ghostty/config`

### Starship — Your Prompt

[Starship](https://starship.rs) is the line that appears before your cursor. It shows you where you are and what's happening in your git repo — and it renders in under 50ms.

**What you see:**

```
~/Desktop/CODING/my-project  main ?1 !2                        2.1s
❯
```

- **Directory** — truncated to 3 levels, with smart substitutions (`Desktop/CODING` → `code`)
- **Git branch** — the current branch name (e.g., `main`)
- **Git status** — `?` untracked, `!` modified, `+` staged, `=` conflicts, `⇡` ahead, `⇣` behind
- **Command duration** — shown when a command takes longer than 2 seconds
- **❯** — green when the last command succeeded, red when it failed

Language versions (Python, Rust) appear on the right side only when you're in a project that uses them.

**Config location:** `starship/starship.toml`

### Zsh Plugins — Smarter Shell

Four plugins are installed via [zinit](https://github.com/zdharma-continuum/zinit), all loaded lazily to keep startup fast (~150ms):

| Plugin | What It Does |
|--------|-------------|
| **zsh-autosuggestions** | Shows a faded suggestion as you type, based on your history. Press `Ctrl + Space` to accept. |
| **fast-syntax-highlighting** | Colors your commands as you type — green for valid commands, red for typos. |
| **zsh-completions** | Adds completions for hundreds of tools (docker, git, npm, etc.). Press `Tab` to use. |
| **zsh-you-should-use** | Nudges you when you type a full command that has a shorter alias. Helps you learn your aliases. |

### Modern CLI Replacements

These tools replace slow, bare-bones Unix defaults with fast, colorful, feature-rich alternatives. They're aliased so you use them automatically:

#### bat → replaces `cat`

```bash
cat file.py           # syntax highlighted, line numbers, paging
catp file.py          # plain mode (no line numbers, no decoration)
```

Also used as the man page viewer — try `man git`.

#### eza → replaces `ls`

```bash
ls                    # icons, directories first, color by file type
l                     # same as ls
ll                    # long format with permissions, sizes, git status
lt                    # tree view, 2 levels deep
llt                   # tree view, 3 levels, long format
```

#### fd → replaces `find`

```bash
fd "\.py$"            # find all Python files (recursive, ignores .git)
fd -t d config        # find directories named "config"
```

#### ripgrep → replaces `grep`

```bash
rg "TODO"             # search file contents recursively, super fast
rg "TODO" --type py   # search only Python files
```

Pre-configured to use smart case, search hidden files, and ignore build directories (`node_modules/`, `dist/`, `.git/`, etc.).

#### zoxide → replaces `cd`

```bash
cd my-project         # zoxide learns this path
# ...later, from anywhere:
cd my                 # jumps back to ~/Desktop/CODING/my-project
```

The more you use it, the smarter it gets. It ranks directories by frequency and recency.

#### delta → replaces `diff`

You don't call delta directly — it's configured as the git pager. Whenever you run `git diff`, `git show`, or `git log -p`, you'll see beautiful side-by-side diffs with syntax highlighting.

### Git Superpowers

This setup gives you three layers of git tooling:

#### 1. Shell aliases (quick commands)

| Alias | Command | Use When |
|-------|---------|----------|
| `gs` | `git status -sb` | Quick status check |
| `gl` | `git log --oneline --graph -20` | Browse recent history |
| `gla` | `git log --oneline --graph --all` | See all branches |
| `gd` | `git diff` | See unstaged changes |
| `gds` | `git diff --staged` | See what you're about to commit |
| `ga file` | `git add file` | Stage a file |
| `gaa` | `git add .` | Stage everything |
| `gc` | `git commit` | Commit (opens editor) |
| `gcm "msg"` | `git commit -m "msg"` | Quick commit |
| `gca` | `git commit --amend` | Fix the last commit |
| `gco branch` | `git checkout branch` | Switch branches |
| `gcb new-branch` | `git checkout -b new-branch` | Create & switch to a new branch |
| `gp` | `git pull --rebase` | Pull with rebase (cleaner history) |
| `gpsh` | `git push` | Push |
| `gpshf` | `git push --force-with-lease` | Force push (safe — won't overwrite others' work) |
| `gf` | `git fetch --all --prune` | Fetch & clean stale remote branches |
| `gst` | `git stash` | Stash changes |
| `gstp` | `git stash pop` | Restore stashed changes |
| `grb` | `git rebase` | Rebase |
| `gwip` | Add all + commit "WIP [skip ci]" | Quick save of work in progress |

#### 2. Git config aliases (via `git <alias>`)

| Alias | Command |
|-------|---------|
| `git undo` | Soft-reset last commit (keeps changes) |
| `git amend` | Amend last commit without editing message |
| `git graph` | Visual branch graph (last 20 commits) |
| `git branches` | Branches sorted by most recent commit |
| `git stale` | Branches that have been merged (safe to delete) |
| `git contributors` | Contributor leaderboard |
| `git conflicts` | Files with merge conflicts |
| `git last` | Show last commit with diff stats |

#### 3. Lazygit (full git UI)

```bash
lg              # opens lazygit
```

Lazygit gives you a full visual interface for staging, committing, branching, rebasing, and more — all from the keyboard. It's especially useful for:

- Staging individual lines or hunks (not just whole files)
- Interactive rebasing
- Resolving merge conflicts visually
- Browsing commit history

Press `?` inside lazygit to see all keybindings.

### Fuzzy Finding Everything

[fzf](https://github.com/junegunn/fzf) is the backbone of the interactive experience. It turns any list into a searchable, filterable menu.

**Built-in shortcuts (work anywhere in the shell):**

| Shortcut | What It Does |
|----------|-------------|
| `Ctrl + T` | Search for a file by name, insert the path |
| `Ctrl + R` | Search shell history (via atuin) |
| `Alt + C` | Search for a directory, cd into it |

**Custom functions that use fzf:**

| Command | What It Does |
|---------|-------------|
| `fe` | Find a file and open it in your editor |
| `fcd` | Find a directory and cd into it |
| `gbr` | Switch git branches with a preview of recent commits |
| `glog` | Browse git log, preview diffs, copy commit hash |
| `zz` | Jump to any directory zoxide has learned about |

**Inside fzf menus:**

- Type to filter results
- `Ctrl + D` / `Ctrl + U` — scroll half page down/up
- `Ctrl + /` — toggle the preview panel
- `Ctrl + Y` or `Enter` — select
- `Esc` — cancel

### File Management with Yazi

[Yazi](https://yazi-rs.github.io) is a terminal file manager. Think of it like Finder, but in the terminal with keyboard navigation and image previews.

```bash
y               # open yazi in the current directory
```

- **Arrow keys** or **h/j/k/l** — navigate
- **Enter** — open file / enter directory
- **Space** — select files
- **d** — delete selected
- **r** — rename
- **q** — quit (your terminal `cd`s to wherever you navigated)

The theme is configured with Catppuccin Mocha colors and file-type-specific color coding.

### Version Management with Mise

[Mise](https://mise.jdx.dev) manages programming language versions. It replaces the need for `nvm` (Node), `pyenv` (Python), `rbenv` (Ruby), etc. — one tool for all languages.

**What's pre-installed:**

- **Node.js** — LTS version
- **Python** — latest version

**Common commands:**

```bash
mise list               # see installed versions
mise use node@20        # switch to Node 20 for this project
mise use python@3.12    # switch to Python 3.12 for this project
mise install            # install versions specified in config
```

Mise reads `.tool-versions` or `mise.toml` files in your project directories, so each project can use its own language versions automatically.

**Config location:** `mise/config.toml` — edit to add more languages (Ruby, Go, Bun, Deno, etc. are commented out and ready to enable).

### GitHub CLI

[gh](https://cli.github.com) lets you interact with GitHub from the terminal. First-time setup:

```bash
gh auth login           # authenticate (one-time)
```

**Custom aliases:**

| Command | What It Does |
|---------|-------------|
| `gh mine` | List your open PRs |
| `gh rv` | List PRs requesting your review |
| `gh co 123` | Check out PR #123 locally |
| `gh dash` | Open the current repo in your browser |
| `gh prc` | Create a PR in your browser |
| `gh prv` | View the current PR in your browser |
| `gh runs` | Show the last 5 CI runs |
| `gh last-run` | View logs from the latest CI run |

---

## Shell Aliases Cheat Sheet

### Navigation

| Alias | Action |
|-------|--------|
| `..` | `cd ..` |
| `...` | `cd ../..` |
| `....` | `cd ../../..` |
| `-` | `cd -` (previous directory) |

### Development

| Alias | Action |
|-------|--------|
| `vim` / `v` | Opens Neovim |
| `c` | Opens VS Code in current directory |
| `o` | Opens Finder in current directory |

### Package Managers

| npm | yarn | bun | pnpm | Action |
|-----|------|-----|------|--------|
| `ni` | `yr` | `bi` | `pi` | Install dependencies |
| `ns` | — | — | — | Start |
| `nr` | — | `br` | `pr` | Run script |
| `nd` | — | `bd` | `pd` | Run dev server |
| `nb` | — | — | — | Build |
| `nt` | — | — | — | Test |

### System

| Alias | Action |
|-------|--------|
| `path` | Print each PATH entry on its own line |
| `ports` | Show processes listening on TCP ports |
| `ip` | Show your public IP address |
| `localip` | Show your local network IP |
| `flushdns` | Flush the DNS cache |
| `cleanup` | Delete all `.DS_Store` files recursively |
| `reload` | Reload the shell config |

---

## Power Functions

These are custom shell functions for common workflows:

| Command | What It Does |
|---------|-------------|
| `gbr` | Fuzzy switch git branches — shows a preview of recent commits for each branch |
| `glog` | Interactive git log — pick a commit to preview its diff, copies the hash to clipboard |
| `fe` | Fuzzy find any file and open it in your editor |
| `fcd` | Fuzzy find any subdirectory and cd into it |
| `zz` | Jump to any directory zoxide knows about, with a tree preview |
| `y` | Open yazi file manager — when you quit, your terminal is in the directory you navigated to |
| `week` | Summary of your git work from the past 7 days |
| `today` | Show your git commits from today |
| `note "text"` | Append a timestamped note to `~/.notes/YYYY-MM-DD.md` |
| `note` | Open today's note file in your editor |
| `mkcd dir` | Create a directory and cd into it in one step |
| `extract file` | Extract any archive (`.zip`, `.tar.gz`, `.7z`, `.rar`, etc.) |
| `killport 3000` | Kill whatever process is using port 3000 |
| `serve` | Start a quick HTTP server in the current directory (default port 8000) |

---

## Customization

### Machine-Specific Overrides

Two `.local` files let you customize without touching the repo (they're gitignored and never overwritten by the installer):

#### `~/.zshrc.local` — Shell overrides

Add extra aliases, PATH entries, or environment variables:

```bash
# Extra PATH entries
export PATH="$HOME/custom/bin:$PATH"

# Work-specific aliases
alias vpn="networksetup -connectpppoeservice 'Work VPN'"
alias k="kubectl"
alias dc="docker compose"

# Override the default editor
export EDITOR="cursor"
```

#### `~/.gitconfig.local` — Git identity

This is created during installation. You can edit it anytime:

```ini
[user]
    name = Your Name
    email = your@email.com
    # signingkey = YOUR_GPG_KEY

# Uncomment for GPG commit signing:
# [commit]
#     gpgsign = true
```

### Swap the Theme

Edit `ghostty/config` and change this line:

```
theme = catppuccin-mocha
```

Ghostty supports many [built-in themes](https://ghostty.org/docs/config/reference#theme). The rest of the tools (fzf, bat, eza, starship, lazygit, yazi, atuin) also use Catppuccin Mocha — for a fully consistent experience with a different theme, you'd need to update each tool's config.

### Swap the Font

Edit `ghostty/config` and change:

```
font-family = "Monaspace Neon"
```

to any font installed on your system. [Fira Code](https://github.com/tonsky/FiraCode) is already installed as a fallback:

```
font-family = "Fira Code"
```

### Add a Shader

Ghostty supports custom GLSL shaders for visual effects. To enable one, add this line to `ghostty/config`:

```
custom-shader = shaders/bloom.glsl
```

The included `bloom.glsl` adds a subtle glow around bright text. You can find more community shaders online.

### Add Your Own Aliases

Add them to `~/.zshrc.local` for machine-specific aliases (won't be committed), or edit `zsh/zshrc` directly if you want them in the repo.

---

## Optional: macOS System Defaults

```bash
~/.dotfiles/macos.sh
```

This script applies power-user system preferences. **Run it once on a new machine**, then log out and back in.

**What it changes:**

| Category | Changes |
|----------|---------|
| **Keyboard** | Blazing fast key repeat (essential for vim/terminal). Disables press-and-hold, smart quotes, smart dashes, auto-correct, and auto-capitalize. |
| **Dock** | Auto-hides with zero delay, fast animation (0.15s), minimizes to app icon, hides recent apps. |
| **Finder** | Shows hidden files, path bar, status bar, and full POSIX path in the title. Defaults to list view. Searches the current folder (not the whole Mac). |
| **Screenshots** | Saves to `~/Screenshots` as PNG without window shadows. |
| **System** | Expanded save/print dialogs by default (no more clicking "expand" every time). |

> **Note:** Some changes require a logout or restart to take full effect. The script automatically restarts Dock and Finder.

---

## How It All Works

Understanding the structure helps when you want to customize things.

### Repo structure

```
~/.dotfiles/
├── install.sh              # Installer — run to set up or re-run safely
├── uninstall.sh            # Removes symlinks, optionally restores backups
├── macos.sh                # macOS system preferences
├── Brewfile                # List of tools installed by Homebrew
│
├── ghostty/                # Terminal emulator
│   ├── config              # Main Ghostty config
│   ├── shaders/            # Visual effects
│   │   └── bloom.glsl
│   └── themes/             # Color themes
│       └── catppuccin-mocha
│
├── zsh/                    # Shell
│   ├── zshrc               # Main shell config → ~/.zshrc
│   └── zshrc.local.example # Template for machine-specific overrides
│
├── starship/               # Prompt
│   └── starship.toml       # → ~/.config/starship.toml
│
├── git/                    # Git
│   ├── gitconfig           # → ~/.gitconfig
│   ├── gitconfig.local.example  # Template for name/email
│   ├── gitignore_global    # → ~/.gitignore_global
│   └── ripgreprc           # → ~/.ripgreprc
│
├── lazygit/                # Git UI
│   └── config.yml          # → ~/.config/lazygit/config.yml
│
├── atuin/                  # Shell history
│   └── config.toml         # → ~/.config/atuin/config.toml
│
├── yazi/                   # File manager
│   └── theme.toml          # → ~/.config/yazi/theme.toml
│
├── gh/                     # GitHub CLI
│   └── config.yml          # → ~/.config/gh/config.yml
│
└── mise/                   # Version manager
    └── config.toml         # → ~/.config/mise/config.toml
```

### How symlinks work

The installer creates symbolic links (shortcuts) from where each tool looks for its config to the files in this repo:

```
~/.zshrc  →  ~/.dotfiles/zsh/zshrc
~/.config/ghostty  →  ~/.dotfiles/ghostty
~/.config/starship.toml  →  ~/.dotfiles/starship/starship.toml
...
```

This means:

- **Editing** `~/.dotfiles/zsh/zshrc` and editing `~/.zshrc` are the same thing
- **Changes are instant** — no need to "apply" or re-run anything (just `reload` or restart your terminal for shell changes)
- **`git diff`** in the dotfiles repo shows exactly what you've changed

---

## Updating

To pull the latest changes:

```bash
cd ~/.dotfiles
git pull
```

Most changes take effect immediately thanks to symlinks. If the `Brewfile` changed (new tools added), re-run:

```bash
~/.dotfiles/install.sh
```

---

## Uninstalling

```bash
~/.dotfiles/uninstall.sh
```

This will:

1. Remove all symlinks (only symlinks — real files are never touched)
2. Ask if you want to restore from your latest backup (`~/.dotfiles-backup-YYYYMMDD/`)

Your `.local` files (`~/.zshrc.local`, `~/.gitconfig.local`) are always preserved.

The uninstaller does **not** remove Homebrew or any installed tools. To remove those, use `brew uninstall <tool>`.

---

## Troubleshooting

### "command not found" after installation

Restart your terminal or run `exec zsh`. If the problem persists, make sure Homebrew is in your PATH:

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Ghostty doesn't open or shows errors

Make sure it was installed: `brew list --cask | grep ghostty`. If not, run `brew install --cask ghostty`.

### Fonts look wrong

Rebuild the font cache:

```bash
fc-cache -fv
```

Then restart Ghostty.

### Shell is slow to start

The target is under 150ms. To profile:

1. Uncomment the first and last lines in `zsh/zshrc` (`zmodload zsh/zprof` and `zprof`)
2. Open a new terminal
3. The profiling output shows which plugins take the longest

### Colors look off in another terminal

The Catppuccin theme is configured for Ghostty specifically. Other terminals may not render the 256-color palette the same way. For best results, use Ghostty.

### atuin asks to log in

Atuin works offline by default. The login prompt is for optional cloud sync of your shell history across machines. You can ignore it or run `atuin login` if you want that feature.

### I broke something

Re-run the installer — it's safe to run multiple times:

```bash
~/.dotfiles/install.sh
```

Or restore from backup:

```bash
~/.dotfiles/uninstall.sh   # say "y" when asked to restore
```

---

## Acknowledgments

- [Catppuccin](https://catppuccin.com) — the pastel theme that ties everything together
- [Monaspace](https://monaspace.githubnext.com) — GitHub's monospace font family
- [Ghostty](https://ghostty.org) — Mitchell Hashimoto's terminal emulator
