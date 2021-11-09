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
 ##

###
 # Paths, etc.
 #
 # @since   Tuesday, September 7, 2021
 # @updated Tuesday, September 7, 2021 Introduced
 ##
function __set_exports {

	# export PAGER="highlight --out-format ansi --syntax=html --force --no-trailing-nl" # I can scroll and highlist
	export PAGER="cat" # Just use cat for now.
	export HOMEBREW_BUNDLE_FILE="$HOME/.Brewfile" # brew nundle nob.
	export HOMEBREW_BUNDLE_NO_LOCK=true; # Don't make a lock file.

	# Paths
	export PATH="$HOME/.composer/vendor/bin:$PATH"
	export PATH="$HOME/bin:$PATH"
	export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH" # subl
	export PATH="/opt/homebrew/sbin:$PATH" # Homebrew
	export PATH="/opt/homebrew/bin:$PATH" # Homebrew
	export PATH="/opt/homebrew/opt/ruby/bin:$PATH" #  Ruby
	export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH" # Open SSL

	###
	 # Misc Nobs
	 #
	 # @since Friday, 10/2/2020
	 ##
	export COMPOSER_PROCESS_TIMEOUT=60 # Fail after x seconds.
	export LESS="-F -X -R $LESS" # Don't pager on less.
	export MANPAGER='ul | cat -s' # Don't use less.

	###
	 # Editors.
	 #
	 # @since Thursday, 5/13/2021
	 ##
	export EDITOR='vim'
	export GIT_EDITOR='vim'
	export VISUAL='vim'

	###
	 # ZSH & oh-my-zsh Specific Configs
	 #
	 # E.g:
	 #
	 # @since Thursday, 10/1/2020
	 ##
	export UPDATE_ZSH_DAYS=90
	export ZSH="$HOME/.oh-my-zsh" # Path to your oh-my-zsh installation.
}

###
 # Options
 #
 # @since   Tuesday, September 7, 2021
 # @updated Tuesday, September 7, 2021 Introduced
 ##
function __set_opts {

	###
	 # Enable history between panels.
	 #
	 # @since Thursday, 10/1/2020
	 ##
	unsetopt inc_append_history
	unsetopt share_history

	setopt no_monitor # For commands below eding in &, do not report done when running in background.

	# Don't show last login message, e.g. you have mail, etc.
	touch "$HOME/.hushlogin"
}

###
 # Secure ZSH stuff
 #
 # @since   Thursday, 10/1/2020
 # @updated Tuesday, September 7, 2021 Introduced
 ##
function __load_secure_zsh_config {

	if ! [ -f "$HOME/.zshrc-secure" ]; then
		return
	fi

	source "$HOME/.zshrc-secure"
}

###
 # VCSH Stuff
 #
 # @since   Tuesday, September 7, 2021
 # @updated Tuesday, September 7, 2021 Introduced
 ##
function __setup_vcsh {
	() {

		## VCSH (Setup .gitignore for my public and private).
		vcsh write-gitignore pub
		vcsh write-gitignore priv
	} &> /dev/null &
}

###
 # MacOS Default Writes
 #
 # @since   Tuesday, September 7, 2021
 # @updated Tuesday, September 7, 2021 Introduced
 ##
function __write_macos_defaults {
	() {

		###
		 # macOS Default Flags
		 #
		 # @since Thursday, 10/1/2020
		 ##
		defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
		defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
		defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
		defaults write com.apple.TextEdit SmartQuotes -bool false
		defaults write com.apple.TextEdit SmartDashes -bool false
		defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
		defaults write com.apple.screencapture location "$HOME/Pictures/Screenshots"
		defaults write com.apple.desktopservices DSDontWriteNetworkStores true
		defaults write com.apple.Finder QuitMenuItem 1 # Add quit to Finder
		defaults write com.apple.dock springboard-columns -int 7
		defaults write com.apple.dock springboard-rows -int 7 # Launchpad Grid
		defaults write com.apple.Dock autohide-delay -float 0 # Show dock after X seconds, e.g. 99 co.
		defaults write com.apple.dock autohide-time-modifier -int 1 # Also a similar setting.
		defaults write com.apple.dock showhidden -bool false # When Apps are hidden, dim them in Dock.
		defaults write com.apple.dock static-only -bool false # Only show running apps in Dock (when set to true)
		defaults write com.googlecode.iterm2 "Secure Input" 0 # Tell iterm2 to allow non-secure input for escape
		defaults write com.apple.screencapture type jpg # Take jpg screenshots.
		defaults write defaults write com.apple.finder CreateDesktop false # Don't show desktop icons.
	} &> /dev/null &
}

###
 # Aliases
 #
 # @since   Tuesday, September 7, 2021
 # @updated Tuesday, September 7, 2021 Introduced
 ##
function __aliases {

	###
	 # Aliases
	 #
	 # @since Thursday, 10/1/2020 Moved over from .config
	 ##
	alias edit="subl -n"
	alias e="edit"
	alias editzsh="subl -n ~/.zshrc"
	alias ezsh="editzsh"
	alias editgit="subl -n ~/.gitconfig"
	alias egit="editgit"
	alias editssh="subl -n ~/.ssh/config"
	alias essh="editssh"
	alias twin='ttab -w'
	alias c=clear
	alias tower='gittower'

	# Easy composer commands.
	alias cu="composer uninstall"
	alias cis="composer install --prefer-source" # source install.
	alias cid="composer install --prefer-dist" # dist install.
	alias crd="composer uninstall && composer install --prefer-dist" # reinstall with dist.
	alias crs="composer uninstall && composer install --prefer-source" # reinstall with source.
	alias ccc="composer clearcache && composer global clearcache"

	# Composer versions
	alias c@2="composer self-update --2"
	alias c@1="composer self-update --1"

	# Fuzzy find at certain levels easily.
	alias fdd="fd 2" # Two levels.
	alias fd!="fd 10" # Deeper.
	alias fd~="fd 50" # Super deep.

	# Misc.
	alias vim="vim -c 'startinsert'" # Start Vim in insert mode (mostly for commit writing).
	alias repo="cd ~/Repos && fdd" # An easy way to get to a repo using my ffd command.
	alias site="cd ~/Sites && fdd" # Quick way to get to a site
	alias antigengo="cd ~/.antigen && fdd" # An easy way to get to a bundle.

	alias local="cd ~/Sites/Local && fd 3" # An easy way to get to a local.
	alias high='highlight -O ansi'

	# npm install's.
	alias npmib="n auto && npm i && npm run build && b"
	alias npmcib="n auto && npm ci && npm run build && b"
	alias npmrb="npm run build && b"
	alias npmid="n auto && npm i && (npm run dev || npm run watch || npm run start || true)"
	alias npmibd="n auto && npm i && npm run build && (npm run dev || npm run watch || npm run start || true)"

	# Homebrew
	alias brewd="brew bundle dump --file=$HOME/.Brewfile --verbose --all --describe --force --no-lock" # Dump what's installed to my Brewfile

	# Sounds
	alias bell="tput bel"
	alias beep="bell"
	alias b="bell"

	# diff folders
	alias diffd="diff -rq" # Diff a directory.

	# vcsh
	alias pub='vcsh pub'
	alias priv='vcsh priv'

	# Misc
	alias matrix='cmatrix'

	# WP-CLI
	alias wpeach='wp site list --field=url | xargs -n1 -I % wp --url=%' # On each subsite, run a command.
	alias wpdbex='wp db export - | gzip -9 -f >' # Export a database and compress the file.
}

###
 # All things ZSH
 #
 # @since   Tuesday, September 7, 2021
 # @updated Tuesday, September 7, 2021 Introduced
 ##
function __zsh {

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

	# Load
	plugins=(git)

	source $ZSH/oh-my-zsh.sh

	###
	 # Antigen Plugin Manager
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

		# oh-my-zsh
		antigen use oh-my-zsh

		# Builtin:
		antigen bundle git
		antigen bundle wp-cli
		antigen bundle svn
		antigen bundle git-extras
		antigen bundle history-substring-search
		antigen bundle osx
		antigen bundle torifat/npms
		antigen bundle zsh-users/zsh-syntax-highlighting
		antigen bundle zpm-zsh/ls

		# Others:
		antigen bundle Tarrasch/zsh-bd

		# Easy way to require needed commands in my packages.
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-require # export REQUIRE_AUTO_INSTALL="off" # Un-comment to disable autoinstall.

		# My Plugins:
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-x
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-reload
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-fzf-git-branch # Used in my "git fb" alias
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-tdl
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-hide # Hide and unhide folders
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-delete
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-comment # Add comments to a file in macOS.
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-pwdcp # Copy the current pwd.
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-cvideo # Compress a video with cvideo
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-yt2mp3 # Download a YouTube video as an mp3.
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-fd
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-download # Download files using aria2c
		#antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-bruse # I haven't been using this much.
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-git-is-clean

		antigen apply
	fi
}

###
 # Things that can be automatically installed.
 #
 # @since   Tuesday, September 7, 2021
 # @updated Tuesday, September 7, 2021 Introduced
 ##
function __require_and_install_commands {

	###
	 # Required Commands
	 #
	 # - Note, if antigen above hasn't installed yet, a reload will install require and install the below.
	 #
	 # @see   https://github.com/aubreypwd/zsh-plugin-require Uses this bundle to run require function/command.
	 # @since Friday, 10/2/2020                               The initial ones.
	 ##
	if [[ ! $( command -v require ) ]]; then

		echo "Could not find the 'require' function."
		echo "  Please install: https://github.com/aubreypwd/zsh-plugin-require"
	else

		() {

			###
			 # Install homebrew.
			 #
			 # You probably have this installed aready though.
			 #
			 # E.g: brew
			 #
			 # @since Friday, 10/2/2020
			 # @see   https://brew.sh
			 ##
			require "brew" '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"'

			###
			 # Install package managers from homebrew.
			 #
			 # Also installs gem
			 #
			 # @since Friday, 10/2/2020
			 ##
			require "composer" "brew reinstall composer" "brew" # Composer, @see https://composer.org
			require "npm" "brew reinstall node" "brew" # Also installs node.
			require "python" "brew reinstall python" "brew" # Installs pip3 and easy_install
			require "ruby" "brew reinstall ruby" "brew" # Installs gem

			###
			 # Install repo managers.
			 #
			 # @since Friday, 10/2/2020
			 ##
			require "ghq" "brew reinstall ghq" "brew"

			###
			 # Homebrew Requirements
			 #
			 # @since Friday, 10/2/2020
			 # @see   https://brew.sh
			 ##
			require "curl" "brew reinstall curl" "brew"
			require "m" "brew reinstall m" "brew" # What does this do?
			require "git" "brew reinstall git" "brew"
			require "svn" "brew reinstall subversion" "brew"
			require "ffmpeg" "brew reinstall ffmpeg" "brew"
			require "fzf" "brew reinstall fzf" "brew"
			require "watch" "brew reinstall watch" "brew"
			require "watchexec" "brew reinstall watchexec" "brew"
			require "wget" "brew reinstall wget" "brew"
			require "wp" "brew reinstall wp-cli" "brew"
			require "exa" "brew reinstall exa" "brew" # Exa makes ls even more awesome.
			require "cmatrix" "brew reinstall cmatrix" "brew" # Exa makes ls even more awesome.
			require "terminal-notifier" "brew reinstall terminal-notifier" "brew" # Terminal notifications
			require "highlight" "brew reinstall highlight" "brew" # Highlighting cat

			###
			 # Non-homebrew Requirements
			 #
			 # @since Friday, 10/2/2020
			 ##
			require "hcl" "gem install hcl && hcl config -r"
			require "rainbow" "easy_install rainbow" "easy_install" # Colorize less.

			## https://github.com/RichiH/vcsh
			require "vcsh" "brew reinstall vcsh" "brew"

			## lazygit for git gui
			require "lazygit" "brew install jesseduffield/lazygit/lazygit" "brew" # Used as a GUI in-terminal.
			require "ttab" "npm install ttab -g" "npm" # Used to open new windows in iTerm, etc.

		} &> /dev/null &
	fi
}

###
 # Notify me when repos change.
 #
 # @since   Tuesday, September 7, 2021
 # @updated Tuesday, September 7, 2021 Introduced
 ##
function __watch_repos {

	if [[ ! $( command -v vcsh ) ]]; then

		echo "vcsh missing, please install!"
		return
	fi

	###
	 # A way to output a dirty message.
	 #
	 # @since Friday, August 27, 2021
	 ##
	function __dirty_message {

		full="\e[31m⑂\e[0m \e[33m$1\e[0m is dirty"
		tilde="~"

		echo -e "${full/$HOME/$tilde}"
	}

	###
	 # Wrapper for git-is-clean messaging
	 #
	 # @since Friday, August 27, 2021
	 ##
	function __git-is-clean {
		git-is-clean "$1" || ( __dirty_message "$1" )
	}

	# Watch these repositories for dirtiness.
	__git-is-clean "$HOME/Repos/github.com/aubreypwd/iTerm2"
	__git-is-clean "$HOME/Repos/github.com/aubreypwd/Alfred.alfredpreferences"
	__git-is-clean "$HOME/Repos/github.com/aubreypwd/subl-snippets"

	# Have to do something special here for vcsh.
	vcsh pub diff-index --quiet --ignore-submodules HEAD || __dirty_message "pub"
	vcsh priv diff-index --quiet --ignore-submodules HEAD || __dirty_message "priv"
}

###
 # Final aliases that need to override things loaded below.
 #
 # Sometimes plugins from ZSH, etc write over aliases above,
 # this has to exist to overwrite them again because I believe in
 # freedom.
 #
 # @since   Tuesday, September 7, 2021
 # @updated Tuesday, September 7, 2021 Introduced
 ##
function __alias_overrides {
	alias ls='exa -l -g --icons --tree --level=1 -a' # Enhance exa ls defaults.
	alias ls2='exa -l -g --icons --tree --level=2 -a' # Enhance exa ls defaults.
}

###
 # Misc Things
 #
 # @since   Tuesday, September 7, 2021
 # @updated Tuesday, September 7, 2021 Introduced
 ##
function __misc {

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

	() {

		###
		 # Terminus for Sublime Text 3 Support
		 #
		 # @since Monday, 9/21/2020
		 ##
		if [ "$TERM_PROGRAM" = "Terminus-Sublime" ]; then
			bindkey "\e[1;3C" forward-word
			bindkey "\e[1;3D" backward-word
		fi

		###
		 # Hidden/Unhidden files
		 #
		 # @since Thursday, 10/1/2020
		 ##
		chflags nohidden "$HOME/Applications"
		chflags nohidden "$HOME/Library"
		chflags nohidden "$HOME/.Brewfile"

		composer self-update --1 # Use Composer Version 1 for now...

		# Make sure keys and identities make it into keychain.
		ssh-add -q -A -k

		# Directories
		mkdir -p "$HOME/Pictures/Screenshots"

		brew brewdump # Sync ~/.Brewfile

	} &> /dev/null &
}

###
 # ZSH loader
 #
 # @since  Tuesday, September 7, 2021
 # @updated Tuesday, September 7, 2021
 ##
function __load_zsh {

	###
	 # All the ZSH things.
	 #
	 # @since   Tuesday, September 7, 2021
	 # @updated Tuesday, September 7, 2021 Introduced
	 ##
	if [ -e "$ZSH" ]; then

		# Always load ZSH stuff first.
		__zsh

		# Done
		return 0; # Continue
	fi

	echo ".oh-my-zsh isn't installed!"
	echo "  Install: https://ohmyz.sh/#install"

	return 1; # Do not continue
}

###
 # Functions
 #
 # Functions are just more advanced aliases, these might become
 # their own zsh plugins.
 #
 # @since Monday, October 11, 2021
 ##
function __functions {

	###
	 # Notifications
	 #
	 # E.g: not "Title" "SubTitle" "Message"
	 #
	 # @since
	 ##
	function -- {
		terminal-notifier -title "$1" -subtitle "$2" -message "$3" -activate 'com.googlecode.iterm2' --sound "boop"
	}

	###
	 # Watch files.
	 #
	 # E.g: watchf ./ js,css,php "cmd"
	 #
	 # @since Monday, October 11, 2021
	 ##
	function watchf {
		clear
		watchexec --watch "$1" -e "$2" "$3" -c -p
	}

	###
	 # Hide an app from the Dock.
	 #
	 # E.g: hideindock "Tower"
	 #
	 # @since Monday, October 11, 2021
	 ##
	function hideindock {
		/usr/libexec/PlistBuddy -c 'Add :LSUIElement bool true' "$1/Contents/Info.plist" &> /dev/null
	}

	###
	 # Show an app in the Dock.
	 #
	 # E.g: showindock "Tower"
	 #
	 # @since Monday, October 11, 2021
	 ##
	function showindock {
		/usr/libexec/PlistBuddy -c 'Delete :LSUIElement' "$1/Contents/Info.plist" &> /dev/null
	}
}

autoload -Uz compinit && compinit

###
 # 💾 Do It!
 #
 # @since   Tuesday, September 7, 2021
 # @updated Tuesday, September 7, 2021 Introduced
 ##
__set_exports
__set_opts
__load_secure_zsh_config
__setup_vcsh
__write_macos_defaults
__aliases
__functions
__load_zsh || return # If ZSH fails to load none of the below will be ran.
__require_and_install_commands
__misc
__watch_repos
__alias_overrides
