#!/bin/sh

brew="/usr/local/bin/brew"
if [ -f "$brew" ]
then
  echo "Homebrew is installed, nothing to do here"
else
  echo "Homebrew is not installed, installing now"
  echo "This may take a while"
  echo "Homebrew requires osx command lines tools, please download xcode first"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

fi

#packages=(
#"python3"
#"git"
#"node"
#"tmux"
#"neovim"
#"zsh"
#"antigen"
#"rbenv"
#)
packages=(
"git"
"node"
"zsh"
"antigen"
"rbenv"
)

for i in "${packages[@]}"
do
  brew install $i
  echo "---------------------------------------------------------"
done


echo "installing RCM, for dotfiles management"
brew tap thoughtbot/formulae
brew install rcm
echo "---------------------------------------------------------"

localGit="/usr/local/bin/git"
if [ -f "$localGit" ]
then
  echo "git is all good"
else
  echo "git is not installed"
fi
# Okay so everything should be good
# Fingers cross at least
# Now lets clone my dotfiles repo into .dotfiles/
echo "---------------------------------------------------------"

echo "Cloning edmbn's dotfiles into .dotfiles"

git clone https://github.com/edmbn/dotfiles.git ~/.dotfiles

cd $HOME
echo "running RCM's rcup command"
echo "This is symlink the rc files in .dofiles"
echo "with the rc files in $HOME"
echo "---------------------------------------------------------"

rcup

echo "---------------------------------------------------------"

echo "Install shell integration on iterm"

curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash

echo "---------------------------------------------------------"


echo "running oxs defaults"
~./osx.sh

echo "---------------------------------------------------------"
echo "All done!"
echo "and change your terminal font to source code pro (.config/fonts/Sauce Code Pro Bold Nerd Font Complete.ttf)"
echo "Cheers"
echo "---------------------------------------------------------"

exit 0
