#!/bin/zsh

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

###
 # High Level Options
 #
 # @since Tuesday, April 19, 2022
 ##
export ZSH="$HOME/.oh-my-zsh" # Path to your oh-my-zsh installation.
touch "$HOME/.hushlogin" # Don't show last login message, e.g. you have mail, etc.

###
 # Load ZSH
 #
 # @since   Tuesday, September 7, 2021
 ##
if [ -e "$ZSH" ]; then

	setopt no_monitor # For commands below eding in &, do not report done when running in background.

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
	plugins=()

	# Load
	source $ZSH/oh-my-zsh.sh

	# Make sure that additonal info isn't shown on prompt.
	precmd() {

		setopt localoptions nopromptsubst
		print -P "%F{yellow}$(cmd_exec_time)%f"
		unset cmd_timestamp #Reset cmd exec time.
	}

	###
	 # Antigen Plugins
	 #
	 # I use Antigen to source my various zsh functions and aliases.
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

		source /opt/homebrew/share/antigen/antigen.zsh # brew install antigen

		antigen use oh-my-zsh

		# My Configurations
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-my-opts
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-my-vars
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-my-aliases
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-my-mac-defaults

		# High Level Dependancies
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-require # export REQUIRE_AUTO_INSTALL="off" # Un-comment to disable autoinstall.
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-git-is-clean # Required by my-repos.

		# My Tools
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-my-functions
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-my-repos
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-my-require

		# Other Plugins
		antigen bundle wp-cli
		antigen bundle git-extras
		antigen bundle history-substring-search
		antigen bundle osx
		antigen bundle zsh-users/zsh-syntax-highlighting

		# My Plugins
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

		antigen apply
	fi
else

	echo ".oh-my-zsh isn't installed!"
	echo "  Install: https://ohmyz.sh/#install"
fi

autoload -Uz compinit && compinit

# Aliases we need to override.
alias ls='exa -l -g --icons --tree --level=1 -a' # Enhance exa ls defaults.
alias ll='exa -l -g --icons --tree --level=2 -a' # Enhance exa ls defaults, but show 2 levels deep.

###
 # Quietly
 #
 # @since Tuesday, April 19, 2022
 ##
() {

	###
	 # vcsh Repos
	 #
	 # @since Wednesday, April 20, 2022
	 ##
	vcsh write-gitignore pub # Ignore files by default.
	vcsh write-gitignore priv # Ignore files by default.
	pub pew # Send (modifed) updates up to Git.
	priv pew # Send (modified) updates up to Git.

	npm config set git-tag-version true # When using npm version, automatically push a tag, instead use --git-tag-version

	###
	 # iTerm2 History Support
	 #
	 # @since Monday, 9/21/2020
	 ##
	test -e "${HOME}/.iterm2_shell_integration.zsh" \
		&& source "${HOME}/.iterm2_shell_integration.zsh"

	###
	 # Load fzf autocomplete.
	 #
	 # @since Thursday, 10/1/2020
	 ##
	[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

	###
	 # Hidden/Unhidden Files & Folders
	 #
	 # @since Thursday, 10/1/2020
	 ##
	chflags nohidden "$HOME/Applications"
	chflags nohidden "$HOME/Library"
	chflags nohidden "$HOME/Documents"
	chflags nohidden "$HOME/.Brewfile"

	###
	 # Terminus for Sublime Text 3 Support
	 #
	 # @since Monday, 9/21/2020
	 ##
	if [ "$TERM_PROGRAM" = "Terminus-Sublime" ]; then

		# Fix arrow keys.
		bindkey "\e[1;3C" forward-word
		bindkey "\e[1;3D" backward-word

		# Fix ls.
		alias ls='ls -lah --color' # Use normal alias
	fi

	# Make sure keys and identities make it into keychain.
	ssh-add -q -A -k

	# Directories I want to exist.
	mkdir -p "$HOME/Pictures/Screenshots"


} &> /dev/null &

myrepos
