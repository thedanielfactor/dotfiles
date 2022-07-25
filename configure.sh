#!/bin/bash
set -eou pipefail

source ./script/prompt

brewInstall () {
    # Install brew
    if test ! $(which brew); then
    # Install the correct homebrew for each OS type
        if test "$(uname)" = "Darwin"
        then
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            success 'brew installed'
        elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
        then
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
            success 'brew installed'
        fi
    else
        info 'brew is already installed'
    fi
}

brewUpdate () {
    brew update
    success 'brew updated'
}

zshInstall () {
    # zsh install
    # todo add in check for macOS 10.15 since zsh is default
    if test $(which zsh); then
        info "zsh already installed..."
    else
        brew install zsh zsh-completions
        success 'zsh and zsh-completions installed'
    fi
}

zshZInstall () {
    # Install z for dir searching
    if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-z" ]; then
        info "zsh-z already exists..."
    else
        git clone https://github.com/agkozak/zsh-z ~/.oh-my-zsh/custom/plugins/zsh-z
        success 'zsh-z installed'
    fi
}

configureGitCompletion () {
    GIT_VERSION=`git --version | awk '{print $3}'`
    URL="https://raw.github.com/git/git/v$GIT_VERSION/contrib/completion/git-completion.bash"
    success "git-completion for $GIT_VERSION downloaded"
    if ! curl "$URL" --silent --output "$HOME/.git-completion.bash"; then
        echo "ERROR: Couldn't download completion script. Make sure you have a working internet connection." && exit 1
        fail 'git completion download failed'
    fi
}

ohmyzshInstall () {
    # oh-my-zsh install
    if [ -e ~/.oh-my-zsh/oh-my-zsh.sh ] ; then
    info 'oh-my-zsh is already installed...'
    read -p "Would you like to update oh-my-zsh now? y/n " -n 1 -r
    echo ''
        if [[ $REPLY =~ ^[Yy]$ ]] ; then
        cd ~/.oh-my-zsh && git pull
            if [[ $? -eq 0 ]]
            then
                success "Update complete..." && cd
            else
                fail "Update not complete..." >&2 cd
            fi
        fi
    else
    echo "oh-my-zsh not found, now installing oh-my-zsh..."
    echo ''
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    success 'oh-my-zsh installed'
    fi
}

ohmyzshPluginInstall () {
    # oh-my-zsh plugin install
    if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-completions" ]; then
        info 'zsh-completions already installed'
    else
        git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions && success 'zsh-completions installed'
    fi
    if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
        info 'zsh-autosuggestions already installed'
    else
        git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && success 'zsh-autosuggestions installed'
    fi
    if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
        info 'zsh-syntax-highlighting already installed'
    else
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && 'zsh-syntax-highlighting installed'
    fi
}

pl9kInstall () {
    # powerlevel9k install
    if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel9k" ]; then
        info 'powerlevel9k already installed'
    else
        echo "Now installing powerlevel9k..."
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k && success 'powerlevel9k installed'
    fi
}

pl10kInstall () {
    # powerlevel10k install
    if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
        info 'powerlevel10k already installed'
    else
        echo "Now installing powerlevel10k..."
        git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k && success 'powerlevel10k installed'
    fi
}

tmuxTpmInstall () {
    # tmux tpm install
    if [ -d "$HOME/.tmux/plugins/tpm" ]; then
        info 'tmux tpm already installed'
    else
        echo "Now installing Tmux TPM manager..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && success 'tmux tpm manager installed'
    fi
}

fubectlInstall () {
    # fubectl install
    # todo - move to after ~/bin check on bootstrap
    if [ -f "$HOME/bin/fubectl.source" ]; then
        info 'fubectl.source already exists'
    else
        echo "Now installing fubectl..."
        curl -o "$HOME/bin/fubectl.source" -LO https://rawgit.com/kubermatic/fubectl/master/fubectl.source && success "fubectl placed in $HOME/bin"
    fi
}

neovimBootstrap () {
  brew install xsel
  brew install fd
  brew install ssed
  brew install ripgrep
  brew install neovim
  brew install stylua
  brew install prettier
  pip3 install pylint
  pip3 install pylint-django
  pip3 install django-stubs
  pip3 install autopep8
  pip3 install sqlformat
  brew install delve
  pip3 install debugpy
  brew install lazygit
  brew install pandoc
  npm i -g live-server
  brew install unzip
  brew install curl
  npm i -g picgo
  brew install sqlite3
  brew install trash-cli

  if [ -d "$HOME/.config/nvim" ]; then
    echo 'Backing up existing neovim configuration.'
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
    ln -s $HOME/.dotfiles/nvim/ $HOME/.config/nvim && success "NeoVim config backup and symlink created"
  fi
}

# brew setup
brewInstall
brewUpdate

# zsh setup
zshInstall
zshZInstall
configureGitCompletion

# Neovim bootstrap
neovimBootstrap

# Pull down personal dotfiles
echo ''
read -p "Do you want to use thedanielfactor's dotfiles? y/n" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo ''
	echo "Now pulling down thedanielfactor dotfiles..."
	git clone https://github.com/thedanielfactor/dotfiles.git ~/.dotfiles
	echo ''
	cd $HOME/.dotfiles && echo "switched to .dotfiles dir..."
	echo ''
	echo "Checking out macOS dev branch..." && git checkout mac-dev
	echo ''
	echo "Now configuring symlinks..." && $HOME/.dotfiles/script/bootstrap
    echo ''

    if [[ $? -eq 0 ]]
    then
        echo "Successfully configured your environment thedanielfactor's macOS dotfiles..."
    else
        echo "thedanielfactor's macOS dotfiles were not applied successfully..." >&2
fi
else 
	echo ''
    echo "You chose not to apply thedanielfactor's macOS dotfiles. You will need to configure your environment manually..."
	echo ''
	echo "Setting defaults for .zshrc and .bashrc..."
	echo ''
	echo "source $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc && echo "added zsh-syntax-highlighting to .zshrc..."
	echo ''
	echo "source $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc && echo "added zsh-autosuggestions to .zshrc..."
	echo ''
    echo "[ -f ~/bin/fubectl.source ] && source ~/bin/fubectl.source" >> ${ZDOTDIR:-$HOME}/.zshrc && echo "added fubectl to .zshrc..."
	
fi
