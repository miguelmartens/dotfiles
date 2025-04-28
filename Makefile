# Makefile for managing dotfiles

DOTFILES := $(HOME)/.dotfiles

.PHONY: all help
all: help

help:
	@echo "Available targets:"
	@echo "  stow-all         - Stow all dotfiles packages"
	@echo "  unstow-all       - Unstow all dotfiles packages"
	@echo "  brew-install     - Install Homebrew"
	@echo "  brew-bundle      - Install packages from Brewfile"
	@echo "  touchid          - Enable Touch ID for sudo"
	@echo "  brew-dump        - Dump current Homebrew setup to Brewfile"

.PHONY: stow-all
stow-all:
	stow */

.PHONY: unstow-all
unstow-all:
	stow -D */

.PHONY: brew-install
brew-install:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

.PHONY: brew-bundle
brew-bundle:
	brew bundle --describe
	brew bundle --file $(DOTFILES)/Brewfile --force

.PHONY: touchid
touchid:
	sed -e 's/^#auth/auth/' /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local

.PHONY: brew-dump
brew-dump:
	brew bundle dump --file=$(DOTFILES)/Brewfile --force


