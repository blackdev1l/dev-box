function install {
    echo installing $1
    shift
    pacaur -S --noconfirm --noedit "$@" >/dev/null 2>&1
}

echo updating system
sudo pacman -Syu --noconfirm >/dev/null 2>&1

# Create a tmp-working-dir an navigate into it
mkdir -p /tmp/pacaur_install
cd /tmp/pacaur_install

# If you didn't install the "base-devil" group,
# we'll need those.
sudo pacman -S binutils make gcc fakeroot --noconfirm

# Install pacaur dependencies from arch repos
sudo pacman -S expac yajl git --noconfirm

# Install "cower" from AUR
curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cower
makepkg PKGBUILD --skippgpcheck
sudo pacman -U cower*.tar.xz --noconfirm

# Install "pacaur" from AUR
curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=pacaur
makepkg PKGBUILD
sudo pacman -U pacaur*.tar.xz --noconfirm

# Clean up...
cd ~
rm -r /tmp/pacaur_install
install headers linux-headers 
install 'Vbox guest additions' virtualbox-guest-utils 
install Xorg xorg-server
install Rxvt rxvt-unicode
install Rofi rofi 
install Greeter lightdm lightdm-gtk-greeter
install Git git
install vim vim
install Zsh zsh
install Wget wget
install Tmux tmux
install Weechat weechat
install Golang golang
install Fonts ttf-font-icons ttf-inconsolata
install i3 i3-gaps-git
install i3blocks i3blocks

sudo systemctl enable lightdm

echo 'installing vundle for vim'
mkdir -p ~/.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo 'downloading dotfiles'
git clone https://github.com/blackdev1l/dotfiles ~/dotfiles
cp -R ~/dotfiles/.config ~/.config
cp -R ~/dotfiles/.config ~/.config
cp -R ~/dotfiles/.weechat ~/.weechat
cd ~/dotfiles
for fn in $(find . -maxdepth 1 -type f -printf "%f\n"); do
  cp -R  $fn ~/$fn
done

echo 'installing oh my zsh'
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo 'setting up golang workspace'
echo export GOPATH=~/dev/go >> ~/.zshrc
echo export PATH=$GOPATH/bin:$PATH >> ~/.zshrc

echo 'all set, rock on!'
echo 'remember to chsh -s /bin/zsh'
