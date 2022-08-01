#!/bin/bash

###
 # My .zshrc file
 #
 # This is my ~/.zshrc file and it does a lot of things, but mostly it helps me:
 #
 # - Setup my machine
 # - Make things easier to do in the Terminal
 # - Make development super easy
 # - Sometimes make things more complicated than they need to be
 #
 # Most actions are blocked into callable functions all prefixed with __
 # and I call them in a certain order.
 #
 # @since The beginning of time.
 # @since Large update, most things are ZSH plugins now.
 ##

# PATH
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH" # subl
export PATH="/opt/homebrew/sbin:$PATH" # Homebrew
export PATH="/opt/homebrew/bin:$PATH" # Homebrew
export PATH="/opt/homebrew/opt/ruby/bin:$PATH" #  Ruby
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH" # Open SSL
export PATH="/opt/homebrew/lib/ruby/gems/3.0.0/bin:$PATH" # Ruby Gems
export PATH="/usr/local/bin:$PATH" # Just for n, where it symlinks node.

###
 # High Level Options
 #
 # @since Tuesday, April 19, 2022
 ##
export ZSH="$HOME/.oh-my-zsh" # Path to your oh-my-zsh installation.

###
 # Load ZSH
 #
 # @since   Tuesday, September 7, 2021
 ##
if [ -e "$ZSH" ]; then

	###
	 # ZSH & oh-my-zsh Specific Configs
	 #
	 # E.g:
	 #
	 # @since Thursday, 10/1/2020
	 ##
	export UPDATE_ZSH_DAYS=90

	###
	 # Theme
	 #
	 # - Must be done before you shource oh-my-zsh.
	 #
	 # @since Monday, 9/21/2020 frisk
	 # @since 10/1/20           ys
	 # @since Wednesday, 10/7/2020 Switched to refined for more simplicity.
	 ##
	ZSH_THEME="refined"

	# Built-in plugins.
	PLUGINS=()

	# Load Oh My ZSH...
	source "$ZSH/oh-my-zsh.sh"

	###
	 # Antigen Plugins
	 #
	 # I use Antigen to source my various zsh functions and aliases, etc.
	 #
	 # - Think of "bundle" as "plugin".
	 # - E.g. `Tarrasch/zsh-bd` should clone from Github by default
	 # - Cloning using ssh URL ensures the resutling clone is contributable upstream with 2FA
	 #
	 # @see   $HOME/.antigen/bundle                 Where the repos are cloned and sourced from.
	 # @see   https://github.com/zsh-users/antigen  Antigen download and info.
	 #
	 # @since Monday, 9/21/2020
	 ##
	if [[ ! -f "/opt/homebrew/share/antigen/antigen.zsh" ]]; then

		echo "Please install antigen and reload to install ZSH plugins:"
		echo "  Homebrew: brew reinstall antigen"
	else

		# Get antigen ready.
		source /opt/homebrew/share/antigen/antigen.zsh # brew install antigen
		antigen use oh-my-zsh

		# Other Plugins
		antigen bundle git-extras
		antigen bundle history-substring-search
		antigen bundle osx
		antigen bundle zsh-users/zsh-syntax-highlighting

		# Plugins I built (install as source on master).
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-require # export REQUIRE_AUTO_INSTALL="off" # Un-comment to disable autoinstall.
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-git-is-clean # Required by my-repos.
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-x
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-reload
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-fzf-git-branch # Used in my "git fb" alias
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-hide # Hide and unhide folders
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-delete
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-comment # Add comments to a file in macOS.
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-pwdcp # Copy the current pwd.
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-cvideo # Compress a video with cvideo
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-yt2mp3 # Download a YouTube video as an mp3.
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-fd
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-download # Download files using aria2c
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-newvwp # Easy Valet WP site creation.
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-bruse # I haven't been using this much.
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-affwp

		# My configurations (as a plugin).
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-my-config

		antigen apply
	fi
else

	echo ".oh-my-zsh isn't installed!"
	echo "  Install: https://ohmyz.sh/#install"
	exit 2
fi

autoload -Uz compinit && compinit

( (

	mysql-exec "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';"

	if [ "$(pwd)" != "$HOME" ]; then
		return
	fi

	brewd # Dump out a .Brewfile.

	###
	 # Load fzf autocomplete.
	 #
	 # @since Thursday, 10/1/2020
	 ##
	[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

) 1>&- 2>&- & )

###
 # iTerm2 History Support
 #
 # @since Monday, 9/21/2020
 ##
test -e "${HOME}/.iterm2_shell_integration.zsh" \
	&& source "${HOME}/.iterm2_shell_integration.zsh"

if [ "$(pwd)" = "$HOME" ]; then

	checkmyrepos
	sysinfo
else
	test -e ".autorun.zsh" && source ".autorun.zsh" # Run .autorun.zsh files.
fi