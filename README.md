# .dotfiles

This repository contains my personal dotfiles, managed using [GNU Stow](https://www.gnu.org/software/stow/). Stow makes it easy to symlink configuration files and directories into their correct locations in your home directory.

---

## Clone repo into new hidden directory

```zsh
# Use SSH (if set up)...
git clone git@github.com:miguelmartens/dotfiles.git ~/.dotfiles

# ...or use HTTPS and switch remotes later.
git clone https://github.com/miguelmartens/dotfiles.git ~/.dotfiles
```

---

## Install/Update Homebrew and Brewfile packages

To install Homebrew:

```sh
make brew-install
```

To install or update all packages from the Brewfile (and see a description of what will be installed):

```sh
make brew-bundle
```

This will first show a summary of what will be installed (`brew bundle --describe`), then install or update all packages from the Brewfile (`brew bundle --file ~/.dotfiles/Brewfile --force`).

To dump your current Homebrew setup to the Brewfile:

```sh
make brew-dump
```

This will regenerate the Brewfile to match your current Homebrew setup.

---

## Directory Structure

Each application or config is organized as a separate "package" (directory) inside `.dotfiles/`. The internal structure of each package mirrors the desired location in your home directory. For example:

```
.dotfiles/
  kitty/
    .config/
      kitty/
        kitty.conf
        current-theme.conf
  hushlogin/
    .hushlogin
  zsh/
    .zshrc
    .zshenv
    .zshprofile
  starship/
    .config/
      starship/
        starship.toml
  alacritty/
    .config/
      alacritty/
        alacritty.toml
        catppuccin-frappe.toml
        ...
  atuin/
    .config/
      atuin/
        config.toml
  zed/
    .config/
      zed/
        settings.json
        ...
  zellij/
    .config/
      zellij/
        config.kdl
        themes/
          catppuccin.kdl
  git/
    # (add your git configs here)
  Brewfile
  Brewfile.lock.json
  .stowrc
  .gitignore
```

---

## About the `.config` Directory

Many modern Linux and macOS applications store their configuration files in the `~/.config` directory, following the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).
This keeps your home directory organized and avoids clutter from many hidden dotfiles.

When using Stow, you can easily manage these configurations by mirroring the `.config` structure inside each package. For example, to manage Kitty's configuration, place your files in:

```
.dotfiles/kitty/.config/kitty/
```

Stow will then symlink this to `~/.config/kitty/`, ensuring your application picks up the correct configuration.
This approach works for any app that uses `~/.config`, such as Alacritty, Starship, Zellij, Zed, and more.

If you add a new application that uses `.config`, simply create the appropriate directory structure in your dotfiles and stow the package as usual.

---

## Setup dotfiles with Stow

```zsh
# Navigate to dotfiles directory
cd ~/.dotfiles

# Setup Stow (use --adopt when trying to copy/adopt files)
stow .

# Or, to stow all directories at once (excluding files like Brewfile):
stow */

# Check if stow is working
ls -lah ~/
```

- Files like `.hushlogin` that belong directly in `$HOME` are placed in their own package directory (e.g., `hushlogin/.hushlogin`).
- The `.stowrc` file is used to ignore files that should not be symlinked (like `Brewfile`, `README.md`, etc.).
- `.gitignore` is used to avoid committing local or system-specific files.

---

## Python version management with pyenv

```zsh
# Check the available versions
pyenv install --list
# Install Python versions
pyenv install x.x.x
# Set the global version
pyenv global x.x.x
# Check the versions
pyenv versions
# Check Python version
python --version
python3 --version
# Add pyenv-update plugin
git clone https://github.com/pyenv/pyenv-update.git $(pyenv root)/plugins/pyenv-update
pyenv update
```

---

## Adding New Dotfiles

1. Create a new directory for the package (if it doesn't exist).
2. Place your config files inside, mirroring the desired path from your home directory.
3. Run `stow <package>` to symlink.

---

## References
- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/stow.html)
- [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)

---

Feel free to fork and adapt for your own setup!
