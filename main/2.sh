#!/bin/bash


# colored text
pink='\033[95m'
purple='\033[1;35m'
red='\033[1;31m'

# end current color scheme
end='\033[0m'

# status indicators
pink_plus='\033[95m[++]\e[0m'
purple_plus='\033[1;35m[++]\e[0m'
red_plus='\033[1;31m[++]\e[0m'
yellow_plus='\033[0;33m[++]\e[0m'
yellow_minus='\033[0;33m[--]\e[0m'

# time specific
time_background='\u001b[46;1m'

# set current working directory variable
pwd="$PWD"


check_for_root () {
    if [ "$EUID" -eq 0 ]; then
      echo -e "\n Script must not be run as root \n"
      exit 1
    fi
    }


log_time_start() {
  echo -e "\n\n$time_background $(date) $end\n" | sudo tee -a "$pwd"/log > /dev/null
}


log_time_end() {
  echo -e "$time_background $(date) $end\n" | sudo tee -a "$pwd"/log > /dev/null
}


check_for_root
log_time_start

############################## Install Rust, Rustscan and Feroxbuster start #######################################

# check if Rust is already installed - if not then install
if ! command -v ~/.cargo/bin/rustup > /dev/null; then
  # install Rust
  echo -e "\n $red Installing Rust $end \n" | sudo tee -a log
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  if command -v ~/.cargo/bin/rustup > /dev/null; then
    echo -e "\n  $red_plus Rust installation - complete \n" | sudo tee -a log
  fi
else
  echo -e "\n\n  $yellow_plus Rust is already installed, skipping installation. \n" | sudo tee -a log
fi


# check if rust is installed. If it is then check if rustscan is already installed - if not then install.
if command -v ~/.cargo/bin/rustup > /dev/null; then
  if ! command -v ~/.cargo/bin/rustscan > /dev/null; then
    # install rustscan
    echo -e "$red Installing Rustscan $end \n" | sudo tee -a log
    ~/.cargo/bin/cargo install rustscan
    # post installation echo this output
    if command -v ~/.cargo/bin/rustscan > /dev/null; then
      echo -e "\n  $red_plus Rustscan installation - complete \n" | sudo tee -a log
    fi
  else
    echo -e "  $yellow_plus Rustscan is already installed, skipping installation. \n" | sudo tee -a log
  fi
# if rust is not installed then do this
else
  echo -e "\n\n  $yellow_minus rust is not installed, skipping rustscan installation. \n" | sudo tee -a log
fi


# check if rust is installed. If it is then check if feroxbuster is already installed - if not then install.
if command -v ~/.cargo/bin/rustup > /dev/null; then
  if ! command -v ~/.cargo/bin/feroxbuster > /dev/null; then
    # install feroxbuster
    echo -e "$red Installing Feroxbuster $end \n" | sudo tee -a log
    ~/.cargo/bin/cargo install feroxbuster
    # post installation echo this output
    if command -v ~/.cargo/bin/feroxbuster > /dev/null; then
      echo -e "\n  $red_plus Feroxbuster installation - complete \n" | sudo tee -a log
    fi
  else
    echo -e "  $yellow_plus Feroxbuster is already installed, skipping installation. \n\n" | sudo tee -a log
  fi
# if rust is not installed then do this
else
  echo -e "  $yellow_minus rust is not installed, skipping feroxbuster installation. \n\n" | sudo tee -a log
fi

############################## Install Rust, Rustscan and Feroxbuster end #######################################

############################## Install Zsh and Oh-my-zsh or Fish and Oh-my-fish start #######################################

# install zsh or fish
echo -e "Which shell do you want to install? ($pink zsh $end /$purple fish $end)"
read -r shell

if [[ $shell == "zsh" ]]; then
  # install zsh and oh-my-zsh
  echo -e "\n $pink Installing Zsh and Oh-my-zsh $end \n" | sudo tee -a log
  sudo apt-get install -y zsh
  if command -v /usr/bin/zsh > /dev/null; then
    if grep -q /bin/bash /etc/passwd; then
      # convert all bash shells to zsh
      sudo sed -i 's^/bin/bash^/usr/bin/zsh^g' /etc/passwd
      echo -e "$pink_plus /usr/bin/zsh found - root + all user shells converted to zsh" | sudo tee -a log
    fi
    if grep -q /bin/fish /etc/passwd; then
      # convert all fish shells to zsh
      sudo sed -i 's^/bin/fish^/bin/zsh^g' /etc/passwd
      echo -e "$pink_plus /usr/bin/zsh found - root + all user shells converted to zsh" | sudo tee -a log
    fi
  fi
  # oh-my-zsh
  echo -e "\n $pink~~ Shell changed to zsh. Please log out and log back in to finalize the process. ~~ $end \n" | sudo tee -a log
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


elif [[ $shell == "fish" ]]; then
  # install fish, powerfonts, oh-my-fish and bobthefish extension
  echo -e "\n $purple Installing Fish and Oh-my-fish $end \n" | sudo tee -a log
  sudo apt-get install -y fish
  if command -v /usr/bin/fish > /dev/null; then
    if grep -q /bin/bash /etc/passwd; then
      # convert all bash shells to fish
      sudo sed -i 's^/bin/bash^/usr/bin/fish^g' /etc/passwd
      echo -e "$purple_plus $purple/usr/bin/fish found - root + all user shells converted to fish $end" | sudo tee -a log
    fi
    if grep -q /bin/zsh /etc/passwd; then
      # convert all zsh shells to fish
      sudo sed -i 's^/bin/zsh^/bin/fish^g' /etc/passwd
      echo -e "$purple_plus $purple/usr/bin/fish found - root + all user shells converted to fish $end" | sudo tee -a log
    fi
  fi
  # install powerfonts for user
  if [ ! -d "$HOME/Scripts/fonts" ]; then
    # install powerline fonts  
    echo -e "\n $purple Installing powerline $end \n" | sudo tee -a log
    mkdir -p ~/Scripts
    cd ~/Scripts
    git clone https://github.com/powerline/fonts
    cd fonts
    chmod +x install.sh
    ./install.sh
    cd ~
  fi
  # oh-my-fish
  echo -e "\n\n $purple~~ Shell changed to fish. Please log out and log back in to finalize the process ~~ $end \n" | sudo tee -a "$pwd"/log
  # `omf install bobthefish` output to clipboard
  echo -e " $purple~~ Upon completion of oh-my-fish run ~~\n\n ~ omf install bobthefish\n\n ~~ If xclip is installed use SHIFT + CTRL + V ~~$end \n\n" | sudo tee -a "$pwd"/log
  echo -e "fish -c 'omf install bobthefish'" | xclip -selection clipboard
  curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install 
  fish install --path=~/.local/share/omf --config=~/.config/omf
  rm -rf install

else
  echo "$red Invalid shell. Exiting script. $end" | sudo tee -a log
  exit 1

fi

############################## Install Zsh and Oh-my-zsh or Fish and Oh-my-fish end #######################################

log_time_end


