function install {
    echo installing $1
    shift
    yay -S --noconfirm "$@" >/dev/null 2>&1
}

echo "updating system"
sudo pacman -Syu --noconfirm >/dev/null 2>&1

# Create a tmp-working-dir an navigate into it
mkdir -p /tmp/pacaur_install
cd /tmp/pacaur_install

# If you didn't install the "base-devel" group,
# we'll need those.
sudo pacman -S binutils make gcc fakeroot pkgconf git go --noconfirm --needed

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

# Clean up...
cd ~
rm -r /tmp/pacaur_install


install headers linux-headers 
install 'Vbox guest additions' virtualbox-guest-utils virtualbox-guest-modules
install Xorg Xorg
install Rxvt rxvt-unicode
install Rofi rofi 
install lightdm lightdm-gtk-greeter
install Git git
install vim vim
install Zsh zsh
install Wget wget
install Tmux tmux
install Weechat weechat
install Fonts ttf-font-icons ttf-inconsolata
install i3 i3-gaps
install i3blocks i3blocks

sudo systemctl set-default -f graphical.target
sudo systemctl enable lightdm
#sudo echo 'vboxguest vboxsf vboxvideo' > /etc/modules-load.d/virtualbox.conf
sudo userdel -r terry

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
echo export GOPATH=~/dev/go >> ~/.zshrc
echo export PATH=$GOPATH/bin:$PATH >> ~/.zshrc

echo 'all set, rock on!'
echo 'remember to chsh -s /bin/zsh'
sudo reboot
