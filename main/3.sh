#!/bin/bash


# colored text
blue='\033[1;34m'
pink='\033[95m'
purple='\033[1;35m'
orange='\033[0;33m'

# end current color scheme
end='\033[0m'

# time specific
time_background='\u001b[46;1m'

# set current working directory variable
pwd="$PWD"

# get a list of all users on the system
users=$(cut -d: -f1 /etc/passwd)


check_for_root () {
    if [ "$EUID" -ne 0 ]; then
      echo -e "\n Script must be run as root \n"
      exit 1
    fi
    }


log_time_start() {
  echo -e "\n\n$time_background $(date) $end\n" >> "$pwd"/log
}


log_time_end() {
  echo -e "$time_background $(date) $end\n" >> "$pwd"/log
}


check_for_root
log_time_start

##############################Add ~/.local/bin to path start #######################################

# set the umask to create new directories with 755 permissions
echo 'umask 0022' >> /etc/bash.bashrc

# iterate over the list of users
for user in $users; do
  # check if the user's home directory exists
  if [ -d "/home/${user}" ]; then
    # create the .local/bin directory for the user
    if [ ! -d "/home/${user}/.local/bin" ]; then
      mkdir -p "/home/${user}/.local/bin"
      chmod 755 "/home/${user}/.local/bin"
      echo -e "\n\n$orange~~ Directory for ${user} created at:\n ~ /home/${user}/.local/bin" >> log
    fi

    #if batcat is installed create a symbolic link to ensure it can be used as the installed package name i.e `bat`
    if command -v batcat > /dev/null; then
      ln -s /usr/bin/batcat /home/"${user}"/.local/bin/bat 2>/dev/null
      echo -e "\n\n$orange~~ Symbolic link created for bat: ~~\n ~ ln -s /usr/bin/batcat /home/""${user}""/.local/bin/bat" >> log
      #if distribution is Debian then place bat binary in /usr/local/bin/bat
      if [ "$(lsb_release -i | cut -f2)" == "Debian" ]; then
        ln -s /usr/bin/batcat /usr/local/bin/bat 2>/dev/null
        echo -e "\n\n$orange~~ Symbolic link created for bat: ~~\n ~ ln -s /usr/bin/batcat /usr/local/bin/bat" >> log
      fi
    fi


    # if the user has a /bash, /zsh, or /fish shell in /etc/passwd, check to see if .local/bin is presently acknowledged in the user's
    # $PATH environmental variables. If not then add it so any binaries in the user's ~/.local/bin directory are available for use.
    # check if the user is using the bash shell
    if grep -q '/bin/bash' "/etc/passwd"; then
      if ! grep -q 'export PATH="${HOME}/.local/bin:${PATH}"' "/home/${user}/.bashrc"> /dev/null; then
        echo 'export PATH="${HOME}/.local/bin:${PATH}"' >> "/home/${user}/.bashrc"
        echo -e "$orange\n\n~~ Path appended to:\n ~ /home/${user}/.bashrc\n\n~~ Content: ~~\n$end $blue" >> log
        echo '~ export PATH="${HOME}/.local/bin:${PATH}"' >> log
      fi
    fi

    # check if the user is using the zsh shell
    if grep -q '/bin/zsh' "/etc/passwd"; then
      if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "/home/${user}/.zshrc" > /dev/null; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "/home/${user}/.zshrc"
        echo -e "$end\n\n$orange~~ Path appended to:\n ~ /home/${user}/.zshrc\n\n~~ Content: ~~\n$end $blue" >> log
        echo '~ export PATH="$HOME/.local/bin:$PATH"' >> log
      fi
    fi  

    # check if the user is using the fish shell
    if grep -q '/usr/bin/fish' "/etc/passwd"; then
      if ! grep -q 'set -x PATH $PATH $HOME/.local/bin' "/home/${user}/.config/fish/config.fish" 2> /dev/null > /dev/null; then
        echo 'set -x PATH $PATH $HOME/.local/bin' >> "/home/${user}/.config/fish/config.fish"
        echo -e "$end\n\n$orange~~ Path appended to:\n ~ /home/${user}/.config/fish/config.fish\n\n~~ Content: ~~\n$end $blue" >> log
        echo '~ set -x PATH $PATH $HOME/.local/bin' >> log
      fi
    fi
  fi
done

# create the .local/bin directory for the root user
if [ ! -d "/root/.local/bin" ]; then
  mkdir -p "/root/.local/bin"
  chmod 755 "/root/.local/bin"
  echo -e "$end\n\n$orange~~ Root directory created: ~~\n ~ /root/.local/bin" >> log
fi

# if batcat is installed create a symbolic link to ensure it can be used as the installed package name i.e `bat`
if command -v batcat > /dev/null; then
  ln -s /usr/bin/batcat /root/.local/bin/bat 2>/dev/null
  echo -e "\n\n$orange~~ Symbolic link created for bat: ~~\n ~ ln -s /usr/bin/batcat /root/.local/bin/bat" >> log
fi

# add the .local/bin directory to the root user's PATH
if ! grep -q 'export PATH="${HOME}/.local/bin:${PATH}"' "/root/.bashrc"> /dev/null; then
  echo 'export PATH="${HOME}/.local/bin:${PATH}"' >> "/root/.bashrc"
  echo -e "$end\n\n$orange~~ Path appended to:\n ~ /root/.bashrc\n\n~~ Content: ~~\n$end $blue" >> log
  echo '~ export PATH="${HOME}/.local/bin:${PATH}"' >> log
fi


# if .zshrc exists for root then add /root/.local/bin to path
if command ls "$HOME"/.zshrc 2> /dev/null > /dev/null; then
  if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "/root/.zshrc"> /dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "/root/.zshrc"
    echo -e "$end\n\n$orange~~ Path appended to:\n ~ /root/.zshrc\n\n~~ Content: ~~\n$end $blue" >> log
    echo '~ export PATH="${HOME}/.local/bin:${PATH}"' >> log
  fi
fi

# if .config/fish exists for root then add /root/.local/bin to path
if [ -d "$HOME/.config/fish" ]; then
  if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "/root/.config/fish/config.fish" 2> /dev/null > /dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "/root/.config/fish/config.fish"
    echo -e "$end\n\n$orange~~ Path appended to:\n ~ /root/.config/fish/config.fish\n\n~~ Content: ~~\n$end $blue" >> log
    echo '~ export PATH="${HOME}/.local/bin:${PATH}"' >> log
  fi
fi

############################## Add ~/.local/bin to path end #######################################

############################## Add ~/.local/share for root and update tldr for root and users start #######################################

# create the .local/bin directory for the root user
if [ ! -d "/root/.local/share" ]; then
  mkdir -p "/root/.local/share"
  chmod 755 "/root/.local/share"
  echo -e "$end\n\n$orange~~ Tldr specific ~~" >> log
  echo -e "\n\n~~$orange Root directory created: ~~\n ~ /root/.local/share  $end" >> log
fi


# if tldr is installed then update for root
if command -v tldr > /dev/null; then
  echo -e "\n~~$orange tldr update for root ~~\n" | /usr/games/lolcat
  tldr --update
fi

# for users
for user in $users; do
  # check if the user's home directory exists
  if [ -d "/home/${user}" ]; then
    # if tldr is installed then update for user
    if command -v tldr > /dev/null; then
      echo -e "\n~~$orange tldr update for ${user} ~~\n" | /usr/games/lolcat
      su - "${user}" -c "tldr --update && exit"
    fi
  fi
done

############################## Add ~/.local/share for root and update tldr for root and users end #######################################

############################## Add ~/.cargo/bin to path start #######################################


# iterate over the list of users
for user in $users; do
  # Check if the user's home directory exists
  if [ -d "/home/${user}" ]; then
    # add the .cargo/bin directory to the user's PATH
    # check if the user is using the bash shell
    if grep -q '/bin/bash' "/etc/passwd"; then
      if ! grep -q 'export PATH="${HOME}/.cargo/bin:${PATH}"' "/home/${user}/.bashrc"> /dev/null; then
        echo 'export PATH="${HOME}/.cargo/bin:${PATH}"' >> "/home/${user}/.bashrc"
        echo -e "$end\n\n$orange~~ Path appended to:\n ~ /home/${user}/.bashrc\n\n~~ Content: ~~\n$end $blue" >> log
        echo '~ export PATH="${HOME}/.cargo/bin:${PATH}"' >> log
      fi
    fi

    # check if the user is using the zsh shell
    if grep -q '/bin/zsh' "/etc/passwd"; then
      if ! grep -q 'export PATH="$HOME/.cargo/bin:$PATH"' "/home/${user}/.zshrc"> /dev/null; then
        echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> "/home/${user}/.zshrc"
        echo -e "$end\n\n$orange~~ Path appended to:\n ~ /home/${user}/.zshrc\n\n~~ Content: ~~\n$end $blue" >> log
        echo '~ export PATH="${HOME}/.cargo/bin:${PATH}"' >> log
      fi
    fi

    # check if the user is using the fish shell
    if grep -q '/usr/bin/fish' "/etc/passwd"; then
      if ! grep -q 'set -x PATH $PATH $HOME/.cargo/bin' "/home/${user}/.config/fish/config.fish"> /dev/null; then
        echo 'set -x PATH $PATH $HOME/.cargo/bin' >> "/home/${user}/.config/fish/config.fish"
        echo -e "$end\n\n$orange~~ Path appended to:\n ~ /home/${user}/.config/fish/config.fish\n\n~~ Content: ~~\n$end $blue" >> log
        echo '~ export PATH="${HOME}/.cargo/bin:${PATH}"' >> log
      fi
    fi
  fi
done


# search both /root and /home paths and if /.cargo/bin exists, if .bashrc, .zshrc, .config/fish/config.fish are present for /root then add the rust binary path to roots path.
# This prevents the need for users to use sudo when running rust binaries since rust was installed by the user.
# for bash
if command find /root -name '.bashrc' > /dev/null; then
  find /root /home -path '*/.cargo/bin' | head -n 1 | xargs sh -c 'if [ $# -gt 0 ] && ! grep -q "$1" /root/.bashrc; then echo "export PATH=\"$1:\$PATH\"" >> /root/.bashrc; fi' _ 
  if grep -q ".cargo" "/root/.bashrc"; then
    echo -e "$end\n\n$orange~~ Path appended to:\n ~ /root/.bashrc\n\n~~ Content: ~~\n$end $blue" >> log
    if_true=$(grep .cargo ~/.bashrc)
    echo -e "~ $if_true" >> log
  fi
fi

# for zsh
if command find /root -name '.zshrc' > /dev/null; then
  find /root /home -path '*/.cargo/bin' | head -n 1 | xargs sh -c 'if [ $# -gt 0 ] && ! grep -q "$1" /root/.zshrc; then echo "export PATH=\"$1:\$PATH\"" >> /root/.zshrc; fi' _ 2> /dev/null
  if grep -q ".cargo" "/root/.zshrc"; then
    echo -e "$end\n\n$orange~~ Path appended to:\n ~ /root/.zshrc\n\n~~ Content: ~~\n$end $blue" >> log
    if_true=$(grep .cargo ~/.zshrc)
    echo -e "~ $if_true" >> log
  fi
fi

# for fish
if command find /root -path '*/.config/fish' > /dev/null; then
  find /root /home -path '*/.cargo/bin' | head -n 1 | xargs sh -c 'if [ $# -gt 0 ] && ! grep -q "$1" /root/.config/fish/config.fish; then echo "export PATH=\"$1:\$PATH\"" >> /root/.config/fish/config.fish; fi' _ 2> /dev/null
  if grep -q ".cargo" "/root/.config/fish/config.fish"; then
    echo -e "$end\n\n$orange~~ Path appended to:\n ~ /root/.config/fish/config.fish\n\n~~ Content: ~~\n$end $blue" >> log
    if_true=$(grep .cargo ~/.config/fish/config.fish)
    echo -e "~ $if_true" >> log
  fi
fi

############################## Add ~/.cargo/bin to path end #######################################

############################## Add terminator configs start #######################################

# iterate over the list of users
for user in $users; do
  # check if the user's home directory exists
  if [ -d "/home/${user}" ]; then
    if [ ! -d "/home/${user}/.config/terminator" ]; then
      # make /home/user/.config/terminator/config file
      mkdir -p "/home/${user}/.config/terminator"
      echo -e "$end\n\n$orange~~ Terminator configs ~~\n\n ~~ Directory created: ~~\n ~ /home/${user}/.config/terminator" >> log
      chown "${user}":"${user}" /home/"${user}"/.config/terminator
    fi
    # add custom terminator configuration file
    cp ../configs/terminatorconfig /home/"${user}"/.config/terminator/config
    echo -e "$end\n$orange~~ Configuration file added to: ~~\n ~ /home/""${user}""/.config/terminator/config" >> log
    chown "${user}":"${user}" /home/"${user}"/.config/terminator/config 2>/dev/null
  fi
done

# create the .local/bin directory for the root user
if [ ! -d "/root/.config/terminator" ]; then
  # Make /home/user/.config/terminator/config file
  mkdir -p "/root/.config/terminator"
  echo -e "\n\n$orange~~ Terminator configs ~~\n\n ~~ Directory created: ~~\n ~ /root/.config/terminator" >> log
fi
# add custom terminator configuration file
cp ../configs/terminatorconfig /root/.config/terminator/config
echo -e "\n$orange~~ Configuration file added to: ~~\n ~ /root/.config/terminator/config" >> log

############################## Add terminator configs end #######################################

############################## Add aliases start #######################################

# add aliases for root
cp ../aliases/make_bash_and_zsh_aliases.sh /root/aliases.sh
cp ../aliases/make_fish_aliases.sh /root/fish_aliases.sh
cd /root
. ./aliases.sh
. ./fish_aliases.sh 
cp new_aliases.zsh .bash_aliases
echo -e "\n\n$orange~~ Bash aliases added to: ~~\n ~ /root/.bash_aliases" >> "$pwd"/log
rm -rf aliases.sh
rm -rf fish_aliases.sh
if [ -d "/root/.oh-my-zsh" ]; then
  cp new_aliases.zsh /root/.oh-my-zsh/custom/aliases.zsh
  echo -e "\n\n$orange~~ Zsh aliases added to: ~~\n ~ /root/.oh-my-zsh/custom/aliases.zsh" >> "$pwd"/log
fi
rm -rf new_aliases.zsh
if [ -d "/root/.config/fish" ]; then
  fish -c 'fish new_fish_aliases.fish' > /dev/null
  echo -e "\n\n$orange~~ Fish aliases added to: ~~\n ~ /root/.config/fish/functions" >> "$pwd"/log
fi
rm -rf new_fish_aliases.fish
cd "$pwd"

# iterate over the list of users
for user in $users; do
  # check if the user's home directory exists
  if [ -d "/home/${user}" ]; then
    #if ~/.bash_aliases does not exists then run this code
    if [ ! -f "/home/${user}/.bash_aliases" ]; then
      # create /home/user/.bash_aliases
      cp ../aliases/make_bash_and_zsh_aliases.sh /home/"${user}"/aliases.sh
      chown "${user}":"${user}" /home/"${user}"/aliases.sh 2> /dev/null
      cd /home/"${user}"
      # change to specific user when executing script to ensure aliases are user specific
      su - "${user}" -c "bash ./aliases.sh 2> /dev/null > /dev/null && exit"
      cp new_aliases.zsh .bash_aliases
      echo -e "\n\n$orange~~ Bash aliases added to: ~~\n ~ /home/""${user}""/.bash_aliases" >> "$pwd"/log
      if [ -d "/home/${user}/.oh-my-zsh" ]; then
        if [ ! -f "/home/${user}/.oh-my-zsh/custom/aliases.zsh" ]; then
          cp new_aliases.zsh /home/"${user}"/.oh-my-zsh/custom/aliases.zsh 2> /dev/null
          echo -e "\n\n$orange~~ Zsh aliases added to: ~~\n ~ /home/""${user}""/.oh-my-zsh/custom/aliases.zsh" >> "$pwd"/log
        fi
      fi
      rm -rf aliases.sh new_aliases.zsh
      chown "${user}":"${user}" /home/"${user}"/.bash_aliases
      chown "${user}":"${user}" /home/"${user}"/new_aliases.zsh 2> /dev/null
      echo "source /home/${user}/.bash_aliases" | xclip -selection clipboard
      echo -e "$end\n $blue~~ Bash aliases can be found at ~~\n\n ~ cat ~/.bash_aliases\n\n ~~ to update bash aliases run ~~\n\n ~ source ~/.bash_aliases $end" | tee -a "$pwd"/log
    else
      if command -v xclip > /dev/null; then
        echo "source /home/${user}/.bash_aliases" | xclip -selection clipboard
        echo -e "\n $blue~~ Bash aliases can be found at ~~\n\n ~ cat ~/.bash_aliases\n\n ~~ to update bash aliases run ~~\n\n ~ source ~/.bash_aliases\n  $end" | tee -a "$pwd"/log
      fi
    fi

    # if oh-my-zsh is installed then install aliases to ~/.oh-my-zsh/custom/aliases
    if [ -d "/home/${user}/.oh-my-zsh" ]; then
      cp ../aliases/make_bash_and_zsh_aliases.sh /home/"${user}"/aliases.sh 2> /dev/null
      chown "${user}":"${user}" /home/"${user}"/aliases.sh 2> /dev/null
      cd /home/"${user}"
      # change to specific user when executing script to ensure aliases are user specific
      su - "${user}" -c "bash ./aliases.sh 2> /dev/null > /dev/null && exit"
      chown "${user}":"${user}" /home/"${user}"/new_aliases.zsh 2> /dev/null
      cp new_aliases.zsh /home/"${user}"/.oh-my-zsh/custom/aliases.zsh 2> /dev/null
      echo -e "\n\n$orange~~ Zsh aliases added to: ~~\n ~ /home/""${user}""/.oh-my-zsh/custom/aliases.zsh $end" >> "$pwd"/log
      rm -rf aliases.sh new_aliases.zsh
      echo -e "\n\n $pink~~ Zsh aliases can be found at ~~\n\n ~ cat ~/.oh-my-zsh/custom/aliases.zsh\n\n ~~ to update zsh aliases logout or run ~~\n\n ~ source ~/.zshrc\n $end" | tee -a "$pwd"/log
    fi

    # if fish shell has been activated then install aliases to ~/.config/fish/functions
    if [ -d "/home/${user}/.config/fish" ]; then
      cd "$pwd"
      cp ../aliases/make_fish_aliases.sh /home/"${user}"/fish_aliases.sh
      chown "${user}":"${user}" /home/"${user}"/fish_aliases.sh 2> /dev/null
      cd /home/"${user}"
      # change to specific user when executing script to ensure aliases are user specific
      su - "${user}" -c "bash ./fish_aliases.sh 2> /dev/null > /dev/null && exit"
      su - "${user}" -c "fish -c ./new_fish_aliases.fish > /dev/null && exit"
      echo -e "\n\n$orange~~ Fish aliases added to: ~~\n ~ /home/""${user}""/.config/fish/functions $end" >> "$pwd"/log
      rm -rf fish_aliases.sh new_fish_aliases.fish
      echo -e "\n\n $purple~~ Fish aliases will be accessible immediately and can be found at ~~\n\n ~ ls ~/.config/fish/functions\n $end" | tee -a "$pwd"/log
    fi
  fi
done

############################## Add aliases end #######################################

log_time_end


