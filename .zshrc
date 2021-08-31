export HOMEBREW_BUNDLE_FILE="$HOME/.Brewfile" # brew nundle nob.
export HOMEBREW_BUNDLE_NO_LOCK=true;

setopt no_monitor # For commands below eding in &, do not report done when running in background.

# Make sure we have ~/iCloud link in $HOME
ln -sf "$HOME/Library/Mobile Documents/com~apple~CloudDocs" "$HOME/iCloud" &> /dev/null &

# Don't show last login message, e.g. you have mail, etc.
touch "$HOME/.hushlogin"

# Make sure keys and identities make it into keychain.
ssh-add -q -A -k &> /dev/null &

# Directories
mkdir -p "$HOME/Pictures/Screenshots" &> /dev/null &

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
 # macOS Default Flags
 #
 # @since Thursday, 10/1/2020
 ##
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true &> /dev/null &
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false &> /dev/null &
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false &> /dev/null &
defaults write com.apple.TextEdit SmartQuotes -bool false &> /dev/null &
defaults write com.apple.TextEdit SmartDashes -bool false &> /dev/null &
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false &> /dev/null &
defaults write com.apple.screencapture location "$HOME/Pictures/Screenshots"
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
defaults write com.apple.Finder QuitMenuItem 1 &> /dev/null & # Add quit to Finder
defaults write com.apple.dock springboard-columns -int 7
defaults write com.apple.dock springboard-rows -int 7 &> /dev/null & # Launchpad Grid
defaults write com.apple.Dock autohide-delay -float 0 &> /dev/null & # Show dock after X seconds, e.g. 99 co
defaults write com.apple.dock showhidden -bool false &> /dev/null & # When Apps are hidden, dim them in Dock.
defaults write com.apple.dock static-only -bool false &> /dev/null & # Only show running apps in Dock (when set to true)
defaults write com.googlecode.iterm2 "Secure Input" 0 &> /dev/null & # Tell iterm2 to allow non-secure input for escape
defaults write com.apple.screencapture type jpg # Take jpg screenshots.
defaults write defaults write com.apple.finder CreateDesktop false &> /dev/null & # Don't show desktop icons.

###
 # Hide apps from Dock while running
 #
 # @since Sunday, August 22, 2021
 ##
# /usr/libexec/PlistBuddy -c 'Add :LSUIElement bool true' "/Applications/zoom.us.app/Contents/Info.plist" &> /dev/null &

###
 # Enable history between panels.
 #
 # @since Thursday, 10/1/2020
 ##
unsetopt inc_append_history
unsetopt share_history

###
 # Load a .zshrc file that you aren't tracking in VCS.
 #
 # @since Thursday, 10/1/2020
 ##
if [ -f "$HOME/.zshrc.secure" ]; then
	source "$HOME/.zshrc.secure"
fi

###
 # iTerm2 History Support
 #
 # @since Monday, 9/21/2020
 ##
test -e "${HOME}/.iterm2_shell_integration.zsh" \
	&& source "${HOME}/.iterm2_shell_integration.zsh" &> /dev/null &

###
 # Terminus for Sublime Text 3 Support
 #
 # @since Monday, 9/21/2020
 ##
if [ "$TERM_PROGRAM" = "Terminus-Sublime" ]; then
	bindkey "\e[1;3C" forward-word &> /dev/null &
	bindkey "\e[1;3D" backward-word &> /dev/null &
fi

###
 # Load fzf autocomplete.
 #
 # @since Thursday, 10/1/2020
 ##
[ -f ~/.fzf.zsh ] \
	&& source ~/.fzf.zsh &> /dev/null &

###
 # Hidden/Unhidden files
 #
 # @since Thursday, 10/1/2020
 ##
chflags nohidden "$HOME/Applications" &> /dev/null &
chflags nohidden "$HOME/Library" &> /dev/null &
chflags nohidden "$HOME/.Brewfile" &> /dev/null &

###
 # Misc Nobs
 #
 # @since Friday, 10/2/2020
 ##
export COMPOSER_PROCESS_TIMEOUT=60 # Fail after x seconds.
export LESS="-F -X -R $LESS" # Don't pager on less.
export MANPAGER='ul | cat -s' # Don't use less.

composer self-update --1 &> /dev/null & # Use Composer Version 1 for now...

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

###
 # Bail if oh-my-zsh isn't installed yet.
 #
 # @since Thursday, 10/1/2020
 ##
if [ ! -e "$ZSH" ]; then
	echo ".oh-my-zsh isn't installed!"
	echo "  Install: https://ohmyz.sh/#install"
	return
fi

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
	antigen bundle amstrad/oh-my-matrix
	# antigen bundle node
	antigen bundle zsh-users/zsh-syntax-highlighting
	antigen bundle zpm-zsh/ls

	# Others:
	antigen bundle Tarrasch/zsh-bd

	# Easy way to require needed commands in my packages.
	antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-require  # export REQUIRE_AUTO_INSTALL="off" # Un-comment to disable autoinstall.

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
	require "brew" '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"' &> /dev/null &

	###
	 # Install package managers from homebrew.
	 #
	 # Also installs gem
	 #
	 # @since Friday, 10/2/2020
	 ##
	require "composer" "brew reinstall composer" "brew" &> /dev/null & # Composer, @see https://composer.org
	require "npm" "brew reinstall node" "brew" &> /dev/null & # Also installs node.
	require "python" "brew reinstall python" "brew" &> /dev/null & # Installs pip3 and easy_install
	require "ruby" "brew reinstall ruby" "brew" &> /dev/null & # Installs gem

	###
	 # Install repo managers.
	 #
	 # @since Friday, 10/2/2020
	 ##
	require "ghq" "brew reinstall ghq" "brew" &> /dev/null &

	###
	 # Homebrew Requirements
	 #
	 # @since Friday, 10/2/2020
	 # @see   https://brew.sh
	 ##
	require "curl" "brew reinstall curl" "brew" &> /dev/null &
	require "m" "brew reinstall m" "brew" &> /dev/null & # What does this do?
	require "git" "brew reinstall git" "brew" &> /dev/null &
	require "svn" "brew reinstall subversion" "brew" &> /dev/null &
	require "ffmpeg" "brew reinstall ffmpeg" "brew" &> /dev/null &
	require "fzf" "brew reinstall fzf" "brew" &> /dev/null &
	require "watch" "brew reinstall watch" "brew" &> /dev/null &
	require "watchexec" "brew reinstall watchexec" "brew" &> /dev/null &
	require "wget" "brew reinstall wget" "brew" &> /dev/null &
	require "wp" "brew reinstall wp-cli" "brew" &> /dev/null &
	require "exa" "brew reinstall exa" "brew" &> /dev/null & # Exa makes ls even more awesome.
	require "nocommand" "brew tap homebrew/cask-fonts && brew install --cask font-hack-nerd-font" "brew" &> /dev/null & # Helps fonts with ligatures (e.g. exa).

	###
	 # Non-homebrew Requirements
	 #
	 # @since Friday, 10/2/2020
	 ##
	require "hcl" "gem install hcl && hcl config -r" &> /dev/null &
	require "rainbow" "easy_install rainbow" "easy_install" &> /dev/null & # Colorize less.

	## https://github.com/RichiH/vcsh
	require "vcsh" "brew reinstall vcsh" "brew" &> /dev/null &
fi

## VCSH (Setup .gitignore for my public and private).
vcsh write-gitignore pub &> /dev/null &
vcsh write-gitignore priv &> /dev/null &

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

# Brewfile dump (keep it up to date).
if [[ ! $( command -v brew ) ]]; then
	echo "Could not find the 'brew' command."
	echo "  Please install: https://brew.sh so we can dump the .Brewfile"
else
	brew brewdump  &> /dev/null & # Sync ~/.Brewfile
fi

#### FIG ENV VARIABLES ####
# Please make sure this block is at the end of this file.
[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
#### END FIG ENV VARIABLES ####
