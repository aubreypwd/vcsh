#!/bin/zsh

###
 # .zshrc
 #
 # @since Unknown       The beginning of time.
 # @since Unknown       Large update, most things are ZSH plugins now.
 # @since (Jan 16, 2023) Moved a ton of configurations to aubreypwd/zsh-plugin-my-config
 ##

# PATH
export PATH="/opt/homebrew/bin:$HOME/.composer/vendor/bin:$PATH"
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
if test -e "$ZSH"; then

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
	 # @since Monday, 9/21/2020    frisk
	 # @since 10/1/20              ys
	 # @since Wednesday, 10/7/2020 Switched to refined for more simplicity.
	 # @since Apr 6, 2023          Turned off for custom PS1 Prompt.
	 ##
	# export ZSH_THEME="refined"

	# Built-in plugins.
	export PLUGINS=()

	# Load Oh My ZSH...
	source "$ZSH/oh-my-zsh.sh"

	###
	 # Used to clone and link plugins below.
	 #
	 # @since Jan 16, 2023
	 ##
	__clone_and_link_bundle () {

		if test ! -x "$(command -v ghq)"; then
			echo "__clone_and_link_bundle: Please install ghq, can't clone plugin $1."
		fi

		ghq get -s "ssh://git@github.com/$1" 2> /dev/null

		antigen bundle "$HOME/Repos/github.com/$1" --no-local-clone
	}

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

		# omz
		antigen use oh-my-zsh

		# Other Plugins
		antigen bundle git-extras
		antigen bundle history-substring-search
		antigen bundle osx
		antigen bundle zsh-users/zsh-syntax-highlighting
		antigen bundle zsh-users/zsh-autosuggestions

		# My plugins...
		__clone_and_link_bundle "aubreypwd/zsh-plugin-require" ## This has to be loaded first.
		__clone_and_link_bundle "aubreypwd/zsh-plugin-git-is-clean"
		__clone_and_link_bundle "aubreypwd/zsh-plugin-x"
		__clone_and_link_bundle "aubreypwd/zsh-plugin-reload"
		__clone_and_link_bundle "aubreypwd/zsh-plugin-fzf-git-branch"
		__clone_and_link_bundle "aubreypwd/zsh-plugin-hide"
		__clone_and_link_bundle "aubreypwd/zsh-plugin-delete"
		__clone_and_link_bundle "aubreypwd/zsh-plugin-comment"
		__clone_and_link_bundle "aubreypwd/zsh-plugin-pwdcp"
		__clone_and_link_bundle "aubreypwd/zsh-plugin-cvideo"
		__clone_and_link_bundle "aubreypwd/zsh-plugin-yt2mp3"
		__clone_and_link_bundle "aubreypwd/zsh-plugin-fd"
		__clone_and_link_bundle "aubreypwd/zsh-plugin-download"
		__clone_and_link_bundle "aubreypwd/zsh-plugin-newvwp"
		__clone_and_link_bundle "aubreypwd/zsh-plugin-bruse"
		__clone_and_link_bundle "aubreypwd/zsh-plugin-affwp"
		__clone_and_link_bundle "aubreypwd/zsh-plugin-my-config" # This should be loaded last.

		antigen cache-gen
		antigen apply
		antigen cleanup --force 2>&1 /dev/null
	fi
else

	echo ".oh-my-zsh isn't installed!"
	echo "  Install: https://ohmyz.sh/#install"

	exit 2
fi

# Autocomplete
autoload -Uz compinit && compinit

# fzf
test -f "$HOME/.fzf.zsh" && source "$HOME/.fzf.zsh"

# iTerm2
test -e "${HOME}/.iterm2_shell_integration.zsh" \
	&& source "${HOME}/.iterm2_shell_integration.zsh"

# Only when loaded $HOME...
if test "$(pwd)" = "$HOME"; then

	checkmyrepos
	sysinfo

	( ( # Quietly....

		brewd # Dump out a .Brewfile which show up in my public vcsh.

	) 1>&- 2>&- & )
fi
