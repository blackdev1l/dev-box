function install {
    echo installing $1
    shift
    sudo apt-get -y install "$@" >/dev/null 2>&1
}

echo updating package information
apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null 2>&1
apt-get -y update >/dev/null 2>&1

install 'development tools' build-essential
install Git git
install vim vim-nox
install Zsh zsh
install Wget wget
install Tmux tmux
install Weechat weechat
install Golang golang

#install 'i3-gaps dependencies' libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev

echo 'installing vundle for vim'
mkdir -p ~/.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo 'downloading dotfiles'
git clone https://github.com/blackdev1l/dotfiles ~/dotfiles
cp -R ~/dotfiles/.config ~/.config
cp -R ~/dotfiles/.weechat ~/.weechat
cd ~/dotfiles
for fn in $(find . -maxdepth 1 -type f -printf "%f\n"); do
  cp -R  $fn ~/$fn
done

echo 'installing oh my zsh'
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo 'setting up golang workspace'
mkdir -p /dev/go
echo export GOPATH=~/dev/go >> ~/.zshrc
echo export PATH=$GOPATH/bin:$PATH >> ~/.zshrc

echo 'all set, rock on!'
echo 'remember to chsh -s /bin/zsh'
