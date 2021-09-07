#!/bin/zsh

###
 # Paths, etc.
 #
 # @since   Tuesday, September 7, 2021
 # @updated Tuesday, September 7, 2021 First version.
 ##
function __set_exports {

	export HOMEBREW_BUNDLE_FILE="$HOME/.Brewfile" # brew nundle nob.
	export HOMEBREW_BUNDLE_NO_LOCK=true;

	# Oaths
	export PATH="$HOME/.composer/vendor/bin:$PATH"
	export PATH="$HOME/bin:/usr/local/bin:$PATH"
	export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
	export PATH="/usr/local/sbin:$PATH"
	export PATH="/usr/local/lib/node_modules:$PATH"
	export PATH="/usr/local/opt/openssl@1.1/bin:$PATH" # If you need to have openssl@1.1 first in your PATH run

	## Ruby
	export PATH="/usr/local/opt/ruby/bin:$PATH"
	export PATH="/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"

	###
	 # Nobs for compilers to find openssl@1.1
	 #
	 # @since Thursday, 10/1/2020
	 ##
	export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
	export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
	export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig" # For pkg-config to find openssl@1.1 you may need to set:

	###
	 # Hide apps from Dock while running
	 #
	 # @since Sunday, August 22, 2021
	 ##
	# /usr/libexec/PlistBuddy -c 'Add :LSUIElement bool true' "/Applications/zoom.us.app/Contents/Info.plist" &> /dev/null &

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
 # @updated Tuesday, September 7, 2021 First version.
 ##
function __set_options {

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
 # @since   Tuesday, September 7, 2021
 # @updated Tuesday, September 7, 2021 First version.
 ##
function __load_secure_zsh {

	###
	 # Load a .zshrc file that you aren't tracking in VCS.
	 #
	 # @since Thursday, 10/1/2020
	 ##
	if [ -f "$HOME/.zshrc.secure" ]; then
		source "$HOME/.zshrc.secure"
	fi
}

###
 # VCSH Stuff
 #
 # @since   Tuesday, September 7, 2021
 # @updated Tuesday, September 7, 2021 First version.
 ##
function __setup_vcsh {
	() {

		## VCSH (Setup .gitignore for my public and private).
		vcsh write-gitignore pub
		vcsh write-gitignore priv
	}  &> /dev/null &
}

###
 # MacOS Default Writes
 #
 # @since   Tuesday, September 7, 2021
 # @updated Tuesday, September 7, 2021 First version.
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
		defaults write com.apple.Dock autohide-delay -float 0 # Show dock after X seconds, e.g. 99 co
		defaults write com.apple.dock showhidden -bool false # When Apps are hidden, dim them in Dock.
		defaults write com.apple.dock static-only -bool false # Only show running apps in Dock (when set to true)
		defaults write com.googlecode.iterm2 "Secure Input" 0 # Tell iterm2 to allow non-secure input for escape
		defaults write com.apple.screencapture type jpg # Take jpg screenshots.
		defaults write defaults write com.apple.finder CreateDesktop false # Don't show desktop icons.
	}  &> /dev/null &
}

###
 # Aliases
 #
 # @since   Tuesday, September 7, 2021
 # @updated Tuesday, September 7, 2021 First version.
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

	alias ls='ls -lah'
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
		alias goto="fd!" # Just an easier way to get to fd!.
	alias fd~="fd 50" # Super deep.

	# Misc.
	alias vim="vim -c 'startinsert'" # Start Vim in insert mode (mostly for commit writing).
	alias repo="cd ~/Repos && fdd" # An easy way to get to a repo using my ffd command.
	alias antigengo="cd ~/.antigen && fdd" # An easy way to get to a bundle.

	alias locals="cd ~/Sites/Local && fd 3" # An easy way to get to a local.
		alias localsite="locals"
		alias loc="locals"

	# npm install's.
	alias npmib="n auto && npm i && npm run build && b"

	# npm install, build, and DEV
	alias npmid="n auto && npm i && (npm run dev || npm run watch || npm run start || true)"
	alias npmibd="n auto && npm i && npm run build && (npm run dev || npm run watch || npm run start || true)"

	# Homebrew
	alias brewdump="brew bundle dump --file=$HOME/.Brewfile --verbose --all --describe --force --no-lock" # Dump what's installed to my Brewfile

	# Sounds
	alias bell="tput bel"
	alias beep="bell"
	alias b="bell"

	# jq: package.json
	alias jqps="jq .scripts package.json"
	alias jqpi="jq .dependancies package.json"

	# jq: composer.json
	alias jqcs="jq .scripts composer.json"
	alias jqci="jq .require composer.json"

	# diff folders
	alias difff="diff -rq" # Diff a directory.

	# vcsh
	alias pub='vcsh pub'
	alias priv='vcsh priv'

	# Misc
	alias matrix='cmatrix'
}

###
 # All things ZSH
 #
 # @since   Tuesday, September 7, 2021
 # @updated Tuesday, September 7, 2021 First version.
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
	if [[ ! -f "/usr/local/share/antigen/antigen.zsh" ]]; then
		echo "Please install antigen and reload to install ZSH plugins:"
		echo "  Homebrew: brew reinstall antigen"
	else
		source /usr/local/share/antigen/antigen.zsh # brew install antigen

		# oh-my-zsh
		antigen use oh-my-zsh

		# Builtin:
		antigen bundle git
		antigen bundle wp-cli
		antigen bundle svn
		antigen bundle git-extras
		antigen bundle history-substring-search
		antigen bundle osx
		# antigen bundle z
		# antigen bundle npm
		antigen bundle torifat/npms
		# antigen bundle torifat/nnvm
		# antigen bundle amstrad/oh-my-matrix
		# antigen bundle node
		antigen bundle zsh-users/zsh-syntax-highlighting
		antigen bundle zpm-zsh/ls

		# Others:
		antigen bundle Tarrasch/zsh-bd

		# Easy way to require needed commands in my packages.
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-require # export REQUIRE_AUTO_INSTALL="off" # Un-comment to disable autoinstall.

		# My Plugins:
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-x
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-reload
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-fzf-git-branch
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-tdl
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-hide
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-delete
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-comment
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-pwdcp
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-cvideo
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-yt2mp3
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-fd
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-download
		antigen bundle ssh://git@github.com/WebDevStudios/zsh-plugin-satisbuild
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-bruse
		antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-git-is-clean

		antigen apply
	fi
}

###
 # Things that can be automatically installed.
 #
 # @since   Tuesday, September 7, 2021
 # @updated Tuesday, September 7, 2021 First version.
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

			###
			 # Non-homebrew Requirements
			 #
			 # @since Friday, 10/2/2020
			 ##
			require "hcl" "gem install hcl && hcl config -r"
			require "rainbow" "easy_install rainbow" "easy_install" # Colorize less.

			## https://github.com/RichiH/vcsh
			require "vcsh" "brew reinstall vcsh" "brew"

		} &> /dev/null &
	fi
}

###
 # Notify me when repos change.
 #
 # @since   Tuesday, September 7, 2021
 # @updated Tuesday, September 7, 2021 First version.
 ##
function __watch_repos {

	###
	 # A way to output a dirty message.
	 #
	 # @since Friday, August 27, 2021
	 ##
	function __dirty_message {
		echo "🚨  $1 is dirty"
	}

	###
	 # Wrapper for git-is-clean messaging
	 #
	 # @since Friday, August 27, 2021
	 ##
	function __git-is-clean {
		git-is-clean "$1" || ( __dirty_message "$1" && tput bel )
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
 # Misc Things
 #
 # @since   Tuesday, September 7, 2021
 # @updated Tuesday, September 7, 2021 First version.
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

		# Make sure we have ~/iCloud link in $HOME
		ln -sf "$HOME/Library/Mobile Documents/com~apple~CloudDocs" "$HOME/iCloud"

		# Make sure keys and identities make it into keychain.
		ssh-add -q -A -k

		# Directories
		mkdir -p "$HOME/Pictures/Screenshots"

		brew brewdump # Sync ~/.Brewfile

	} &> /dev/null &
}

###
 # All the non-ZSH required things.
 #
 # @since   Tuesday, September 7, 2021
 # @updated Tuesday, September 7, 2021 First version.
 ##
__set_exports
__set_options
__load_secure_zsh
__setup_vcsh
__write_macos_defaults
__aliases

###
 # All the ZSH things.
 #
 # @since   Tuesday, September 7, 2021
 # @updated Tuesday, September 7, 2021 First version.
 ##
if [ -e "$ZSH" ]; then

	# Always load ZSH stuff first.
	__zsh

	# Plugins
	__require_and_install_commands
	__misc
	__watch_repos
else

	echo ".oh-my-zsh isn't installed!"
	echo "  Install: https://ohmyz.sh/#install"
fi
