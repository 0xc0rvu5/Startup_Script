#!/bin/bash


# colored text
blue='\033[1;34m'
green='\033[1;32m'
orange='\033[0;33m'
pink='\033[95m'
purple='\033[1;35m'
red='\033[1;31m'
yellow='\033[1;33m'

# end current color scheme
end='\033[0m'

# status indicators
blue_plus='\033[1;34m[++]\e[0m'
green_plus='\033[1;32m[++]\e[0m'
orange_plus='\033[1;33m[++]\e[0m'
pink_plus='\033[95m[++]\e[0m'
purple_plus='\033[1;35m[++]\e[0m'
yellow_plus='\033[0;33m[++]\e[0m'

# time specific
time_background='\u001b[46;1m'


check_for_root () {
    if [ "$EUID" -ne 0 ]; then
      echo -e "\n Script must be run as root \n"
      exit 1
    fi
    }


start_banner() {
  cat << "EOF"
 ad88888ba                                                                  ad88888ba                        88
d8"     "8b ,d                            ,d                               d8"     "8b                       ""              ,d
Y8,         88                            88                               Y8,                                               88
`Y8aaaaa, MM88MMM ,adPPYYba, 8b,dPPYba, MM88MMM 88       88 8b,dPPYba,     `Y8aaaaa,    ,adPPYba, 8b,dPPYba, 88 8b,dPPYba, MM88MMM
  `"""""8b, 88    ""     `Y8 88P'   "Y8   88    88       88 88P'    "8a      `"""""8b, a8"     "" 88P'   "Y8 88 88P'    "8a  88
        `8b 88    ,adPPPPP88 88           88    88       88 88       d8            `8b 8b         88         88 88       d8  88
Y8a     a8P 88,   88,    ,88 88           88,   "8a,   ,a88 88b,   ,a8"    Y8a     a8P "8a,   ,aa 88         88 88b,   ,a8"  88,
 "Y88888P"  "Y888 `"8bbdP"Y8 88           "Y888  `"YbbdP'Y8 88`YbbdP"'      "Y88888P"   `"Ybbd8"' 88         88 88`YbbdP"'   "Y888
                                                            88                                                  88
                                                            88                                                  88
EOF
}


log_time() {
  echo -e "$time_background $(date) $end\n" >> log
}


log_time_start() {
  echo -e "$time_background $(date) $end\n" > log
}


apt_clean() {
  echo -e "\n  $green_plus running: cleaning cache \n"
  eval apt -y autoclean
  }


apt_update() {
    echo -e "\n  $green_plus running: apt update \n"
    eval apt -y update
    }


apt_upgrade() {
    echo -e "\n  $green_plus running: apt upgrade \n"
    eval apt -y upgrade
    }


apt_autoremove() {
    echo -e "\n  $green_plus running: apt autoremove \n"
    eval apt -y autoremove
    }


apt_update_complete() {
    echo -e "\n  $green_plus apt update - complete"
    }


apt_upgrade_complete() {
    echo -e "\n  $green_plus apt upgrade - complete"
    }


apt_autoremove_complete() {
    echo -e "\n  $green_plus apt autoremove - complete \n"
  }


install_necessary() {
  necessary='apt-transport-https curl wget git xclip mlocate vim-gtk3 terminator zsh fish bat tldr'
  echo -e "  $green_plus necessary packages being installed - complete \n"
  eval apt install -y "$necessary"
  echo -e "${green} \n~~ Necessary packages ~~\n ~ $necessary $end" >> log
  echo -e "\n  $green_plus necessary packages installallation - complete \n"
  }


install_unnecessary() {
  unnecessary='toilet figlet cowsay fortune lolcat boxes'
  echo -e "  $green_plus unnecessary packages being installed - complete \n"
  eval apt install -y "$unnecessary"
  echo -e "$green\n\n~~ Unnecessary packages ~~\n ~ $unnecessary $end\n" >> log
  echo -e "\n  $green_plus unnecessary packages installation - complete \n"
  }


uninstall_unnecessary() {
  unnecessary='toilet figlet cowsay fortune lolcat boxes'
  eval apt remove -y "$unnecessary"
  echo -e "\n  $green_plus unnecessary packages installed - complete"
  }


updates() {
  apt_clean
  apt_update
  apt_upgrade
  apt_autoremove
  apt_update_complete
  apt_upgrade_complete
  apt_autoremove_complete
  install_necessary
  install_unnecessary
}


# iptables ruleset
iptables() {
  command iptables -P INPUT ACCEPT
  command iptables -F
  command iptables -A INPUT -i lo -j ACCEPT
  command iptables -A INPUT -i eno2 -j ACCEPT
  command iptables -A INPUT -p tcp --dport 20000 -j ACCEPT
  command iptables -A INPUT -p tcp --dport 20010 -j ACCEPT
  command iptables -A OUTPUT -p udp --dport 53 --sport 1024:65535 -j ACCEPT
  command iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
  command iptables -P INPUT DROP
  command iptables -P FORWARD DROP
  command iptables -P OUTPUT ACCEPT
  echo -e "#!/bin/bash\n" > ../configs/iptables.sh
  echo -e "iptables set and added too:\n ~ ../configs/iptables.sh\n" | /usr/games/lolcat
  echo -e "command iptables -P INPUT ACCEPT" | tee -a ../configs/iptables.sh | /usr/games/lolcat
  echo -e "command iptables -F" | tee -a ../configs/iptables.sh | /usr/games/lolcat
  echo -e "command iptables -A INPUT -i lo -j ACCEPT" | tee -a ../configs/iptables.sh | /usr/games/lolcat
  echo -e "command iptables -A INPUT -i eno2 -j ACCEPT" | tee -a ../configs/iptables.sh | /usr/games/lolcat
  echo -e "command iptables -A INPUT -p tcp --dport 20000 -j ACCEPT" | tee -a ../configs/iptables.sh | /usr/games/lolcat
  echo -e "command iptables -A INPUT -p tcp --dport 20010 -j ACCEPT" | tee -a ../configs/iptables.sh | /usr/games/lolcat
  echo -e "command iptables -A OUTPUT -p udp --dport 53 --sport 1024:65535 -j ACCEPT" | tee -a ../configs/iptables.sh | /usr/games/lolcat
  echo -e "command iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT" | tee -a ../configs/iptables.sh | /usr/games/lolcat
  echo -e "command iptables -P INPUT DROP" | tee -a ../configs/iptables.sh | /usr/games/lolcat
  echo -e "command iptables -P FORWARD DROP" | tee -a ../configs/iptables.sh | /usr/games/lolcat
  echo -e "command iptables -P OUTPUT ACCEPT" | tee -a ../configs/iptables.sh | /usr/games/lolcat
  echo -e "\n"
  echo -e "${yellow} \n~~ Iptables added. To verify run: ~~\n ~ sudo iptables -L -v\n\n~~ Also added to /configs/iptables.sh: ~~\n$end $blue" >> log | /usr/games/lolcat
  cat ../configs/iptables.sh >> log
  sleep 3
  }

# set permanent iptables rules
# sudo iptables-save > /etc/iptables/rules.v4


# brave
brave() {
  # check if Brave is already installed - if not then install
  if ! command -v brave-browser > /dev/null; then
    # install Brave browser
    eval toilet -f smblock --filter border:metal 'Brave'
    echo -e "$end\n $orange Installing Brave $end \n"
    apt-get update
    curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/brave-browser-release.gpg
    echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com stable main" | tee /etc/apt/sources.list.d/brave-browser-release.list > /dev/null
    apt-get update
    apt-get install -y brave-browser
    echo -e "\n \n~~ Brave ~~\n ~~ Files Added: ~~\n ~ /usr/share/keyrings/brave-browser-archive-keyring.gpg \n ~ /etc/apt/sources.list.d/brave-browser-release.list\n~~ Package installed ~~\n ~ brave-browser" >> log
    echo -e "\n  $orange_plus brave installation - complete \n"
  else
    echo -e "$end $orange_plus Brave is already installed, skipping installation.  $orange_plus \n"
  fi
  }


# vscode
vscode() {
# check if VSCode is already installed - if not then install  
  if ! command -v code > /dev/null; then  
    # Install VSCode  
    echo -e "$end\n $blue Installing Code $end \n"  
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg  
    install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/  
    sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'  
    rm -rf packages.microsoft.gpg
    apt-get update  
    apt-get install -y code
    echo -e "\n \n~~ VSCode ~~\n ~~ Files Added: ~~\n ~ /usr/share/keyrings/packages.microsoft.gpg \n ~ /etc/apt/sources.list.d/vscode.list\n~~ Package installed ~~\n ~ code" >> log
    echo -e "\n $blue_plus vscode installation - complete \n"  
  else  
    echo -e "$end $orange_plus VSCode is already installed, skipping installation. $orange_plus \n"  
  fi
  }


# additional necessary packages post install
additional_packages() {
  others='libpam-tmpdir apt-listchanges debsums apt-show-versions sysstat auditd chkrootkit rkhunter unhide fail2ban unattended-upgrades acct arpwatch shellcheck vlc xpad tor sqlite3 sqlitebrowser python3-pip python3-virtualenv iptables-persistent'
  eval toilet -f smblock --filter border:metal 'Additional'
  eval toilet -f smblock --filter border:metal 'Packages'
  echo -e "\n\n $purple Installing additional relevant packages $end \n\n"
  # additional necessary packages post install
  eval apt -y install "$others"
  echo -e "$green\n \n~~ Additional packages ~~\n ~ $others $end" >> log
  echo -e "\n\n  $purple_plus additional packages installation - complete \n"
  }


# general upkeep
maintenance() {
  eval toilet -f smblock --filter border:metal 'Maintenance'
  echo -e "\n $yellow Maintenance time $end \n"

  # enable unattended-upgrades without user-input
  echo "set unattended-upgrades/enable_auto_updates true" | debconf-communicate > /dev/null
  dpkg-reconfigure -f noninteractive unattended-upgrades
  echo -e "$yellow\n" >> log
  echo -e "$yellow~~ Unattended-upgrades activated ~~ \n" | tee -a log

  # alternatively
  # dpkg-reconfigure -plow unattended-upgrades
  # copy unattended-upgrade conf file to a local file for changes
  cp /etc/apt/apt.conf.d/50unattended-upgrades /etc/apt/apt.conf.d/52unattended-upgrades-local
  echo -e "~~ Copied: ~~\n ~ /etc/apt/apt.conf.d/50unattended-upgrades to /etc/apt/apt.conf.d/52unattended-upgrades-local" >> log
  # additional unattended-upgrades settings
  echo -e "\n~~ Copied: ~~\n ~ /config/02periodic to /etc/apt/apt.conf.d/02periodic \n\n~~ Content: ~~\n$end $blue" >> log
  cp ../configs/02periodic /etc/apt/apt.conf.d/02periodic
  cat ../configs/02periodic >> log
  # reference: https://wiki.debian.org/UnattendedUpgrades

  echo -e "${end}${yellow}\n~~ Rules added to: ~~ \n ~ /etc/apt/apt.conf.d/52unattended-upgrades-local \n $end $blue" | tee -a log
  # insert the below line to the local conf file
  echo -e 'Unattended-Upgrade::Remove-New-Unused-Dependencies "true";' | tee -a /etc/apt/apt.conf.d/52unattended-upgrades-local log
  echo -e 'Unattended-Upgrade::Remove-Unused-Dependencies "true";' | tee -a /etc/apt/apt.conf.d/52unattended-upgrades-local log
  echo -e 'Unattended-Upgrade::AutoFixInterruptedDpkg "true";' | tee -a /etc/apt/apt.conf.d/52unattended-upgrades-local log
  echo -e "$end\n"
  # manually test
  # sudo unattended-upgrade --debug --dry-run


  # enable/disable relevant services post installation
  systemctl enable auditd
  systemctl enable fail2ban
  systemctl enable sysstat
  systemctl enable unattended-upgrades
  echo -e "$red\n\n~~ Services enabled on reboot ~~\n ~ arpwatch auditd fail2ban sysstat unattended-upgrades" >> log
  
  systemctl disable cups
  systemctl disable cups-browsed
  systemctl disable ufw
  echo -e "\n\n~~ Services disabled on reboot ~~\n ~ cups cups-browsed ufw" >> log

  # start/stop relevant services
  systemctl start auditd
  systemctl start fail2ban
  systemctl start sysstat
  systemctl start unattended-upgrades
  echo -e "\n\n~~ Services started ~~\n ~ auditd fail2ban sysstat unattended-upgrades" >> log

  systemctl stop cups
  systemctl stop cups-browsed
  systemctl stop ufw
  echo -e "\n\n~~ Services stopped ~~\n ~ cups cups-browsed ufw $end" >> log

  # arpwatch
  # monitor arpwatch via specific connection. if no connnection is up conn variable will fail
  conn=$(ip -4 -o a | cut -d ' ' -f 2,7 | cut -d '/' -f 1 | awk '{print $1}' | tail -1)
  arpwatch -i "$conn"
  echo -e "$yellow\n\n~~ Arpwatch ~~\n\n~~ Interface added: ~~\n ~ $conn \n" | tee -a log
  touch /etc/arpwatch/"$conn".iface
  echo -e "\n~~ Rules added to: ~~\n ~ /etc/arpwatch/$conn.iface \n $end $blue" | tee -a log
  echo -e "INTERFACES=\"$conn\"\nARGS=\"-N -p\"" | tee -a /etc/arpwatch/"$conn".iface log
  systemctl daemon-reload
  systemctl enable arpwatch@"$conn"
  echo -e "$end\n\n$red~~ Service enabled on reboot ~~\n ~ arpwatch@$conn" >> log
  systemctl start arpwatch@"$conn"
  echo -e "\n\n~~ Service started ~~\n ~ arpwatch@""$conn"" $end" >> log
  
  # reference https://www.mybluelinux.com/arpwatch-monitor-mac-addresses-change/
  # find logs @ /var/lib/arpwatch/

  # auditctl
  # ensure auditctl rules are permanent
  echo -e "\n\n$yellow~~ Auditctl ~~\n\n~~ Rules added to: ~~\n ~ /etc/audit/rules.d/audit.rules \n $end $blue" | tee -a log
  echo -e "-w /etc/passwd -p rwxa -k passwd_access" | tee -a /etc/audit/rules.d/audit.rules log
  echo -e "-w /etc/shadow -p rwxa -k shadow_access" | tee -a /etc/audit/rules.d/audit.rules log
  echo -e "-w /etc/gshadow -p rwxa -k gshadow_access" | tee -a /etc/audit/rules.d/audit.rules log
  echo -e "-w /etc/hosts -p wa -k hosts_file_change" | tee -a /etc/audit/rules.d/audit.rules log
  echo -e "$end"

  # reference `https://www.daemon.be/maarten/auditd.html` for a comprehensive list of rules
  # find logs @ /var/log/audit/

  # generate backup file in case of grub pw and generate a local fail2ban jail
  cp /etc/grub.d/40_custom /etc/grub.d/40_custom_backup
  cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
  echo -e "\n  $yellow_plus maintenance upkeep - complete \n"
  }


cleanup() {
  eval toilet -f smblock --filter border:metal 'Cleaup'
  echo -e "\n $orange Finishing touches $end \n"
  # rkhunter
  # Adjust /etc/rkhunter.conf to ensure updates are functional
  if [ -f "/etc/rkhunter.conf" ]; then
    if grep -q 'MIRRORS_MODE=1' "/etc/rkhunter.conf"; then
      sed -i 's/MIRRORS_MODE=1/MIRRORS_MODE=0/' /etc/rkhunter.conf
    fi
    if grep -q 'UPDATE_MIRRORS=0' "/etc/rkhunter.conf"; then
      sed -i 's/UPDATE_MIRRORS=0/UPDATE_MIRRORS=1/' /etc/rkhunter.conf
    fi
    if grep -q 'WEB_CMD="/bin/false"' "/etc/rkhunter.conf"; then
      sed -i 's^WEB_CMD="/bin/false"^WEB_CMD=""^' /etc/rkhunter.conf
    fi
  fi
  # rkhunter update
  rkhunter --update
  # rkhunter baseline
  rkhunter --propupd
  
  # update file directories for use with `locate`
  updatedb
  
  # save for end so it doesn't interrupt script
  apt install needrestart -y
  apt install debsecan -y
  echo -e "\n  $yellow_plus Cleaup - complete \n"
  }


# banners
banners() {
  eval toilet -f smblock --filter border:metal 'Banners'
  echo -e "$yellow\n\n~~ Banners added too: ~~\n ~ /etc/motd\n ~ /etc/issue\n ~ /etc/issue.net" | tee -a log | /usr/games/lolcat
  echo -e "\n~~ Content: ~~\n $end $blue" >> log
  echo "+----------------------------------------------------+
  | This is a controlled access system. The activities |
  | on this system are monitored.                      |
  | Evidence of unauthorised activities may be         |
  | disclosed to the appropriate authorities.          |
  +----------------------------------------------------+" | tee /etc/motd -a log | /usr/games/lolcat
  echo "+----------------------------------------------------+
  | This is a controlled access system. The activities |
  | on this system are monitored.                      |
  | Evidence of unauthorised activities may be         |
  | disclosed to the appropriate authorities.          |
  +----------------------------------------------------+" | tee /etc/issue | /usr/games/lolcat
  echo "+----------------------------------------------------+
  | This is a controlled access system. The activities |
  | on this system are monitored.                      |
  | Evidence of unauthorised activities may be         |
  | disclosed to the appropriate authorities.          |
  +----------------------------------------------------+" | tee /etc/issue.net | /usr/games/lolcat
  sleep 2
  }


zsh_or_fish() {
  # Install zsh or fish
  echo -e "Which shell do you want to install? ($pink zsh $end /$purple fish $end)"
  read -r shell
  eval toilet -f smblock --filter border:metal "$shell it is"
  sleep 2
  eval toilet -f smblock --filter border:metal 'Before I go...'
  eval toilet -f ivrit 'Linux is fun!' | boxes -d cat -a hc -p h8 | /usr/games/lolcat
  eval /usr/games/fortune | /usr/games/cowsay | /usr/games/lolcat
  sleep 2

  if [[ $shell == "zsh" ]]; then
    eval toilet -f smblock -F gay 'zsh'
    # install zsh and oh-my-zsh
    echo -e "\n $pink Installing Zsh and Oh-my-zsh $end \n" | tee -a log
    apt-get install -y zsh
    if command -v /usr/bin/zsh > /dev/null; then
      if grep -q /bin/bash /etc/passwd; then
        # convert all bash shells to zsh
        sed -i 's^/bin/bash^/usr/bin/zsh^g' /etc/passwd
        echo -e "\n $pink_plus $pink /usr/bin/zsh found - root + all user shells converted to zsh. $end \n" | tee -a log
      fi
      if grep -q /bin/fish /etc/passwd; then
        # convert all fish shells to zsh
        sed -i 's^/bin/fish^/bin/zsh^g' /etc/passwd
        echo -e "\n $pink_plus $pink /usr/bin/zsh found - root + all user shells converted to zsh. $end \n" | tee -a log
      fi
    fi
    # oh-my-zsh
    echo -e "\n $pink~~ Shell changed to zsh. Please log out and log back in to finalize the process. ~~ $end \n" | tee -a log
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


  elif [[ $shell == "fish" ]]; then
    eval toilet -f smblock -F gay 'fish'
    # install fish, oh-my-fish and bobthefish extension
    echo -e "\n $purple Installing Fish and Oh-my-fish $end \n" | tee -a log
    apt-get install -y fish
    if command -v /usr/bin/fish > /dev/null; then
      if grep -q /bin/bash /etc/passwd; then
        # convert all bash shells to fish
        sed -i 's^/bin/bash^/usr/bin/fish^g' /etc/passwd
        echo -e "\n\n $purple_plus $purple /usr/bin/fish found - root + all user shells converted to fish. $end \n" | tee -a log
      fi
      if grep -q /bin/zsh /etc/passwd; then
        # convert all zsh shells to fish
        sed -i 's^/bin/zsh^/bin/fish^g' /etc/passwd
        echo -e "\n\n $purple_plus $purple /usr/bin/fish found - root + all user shells converted to fish. $end \n" | tee -a log
      fi
    fi
    # oh-my-fish
    echo -e "\n $purple ~~ Installing oh-my-fish ~~$end" | tee -a log
    # `omf install bobthefish` output to clipboard
    echo -e "\n $purple~~ Upon completion of oh-my-fish run ~~\n\n ~ omf install bobthefish\n\n ~~ If xclip is installed use SHIFT + CTRL + V ~~$end \n\n" | tee -a log
    echo -e "fish -c 'omf install bobthefish'" | xclip -selection clipboard
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install
    fish install --path=~/.local/share/omf --config=~/.config/omf
    rm -rf install

  else
    echo "$red Invalid shell. Exiting script. $end" | tee -a log
    exit 1

  fi
  }


check_for_root
start_banner


PS3=' ~ '
options=("Install everything"
         "Straight to shell selection"
         "Uninstall unnecessary packages"
         "Quit")


select opt in "${options[@]}"
do
    case $opt in
        "Install everything")
            log_time_start
            updates
            iptables
            brave
            vscode
            additional_packages
            maintenance
            cleanup
            banners
            zsh_or_fish
            log_time
            break
            ;;
        "Straight to shell selection")
            log_time
            zsh_or_fish
            log_time
            break
            ;;
        "Uninstall unnecessary packages")
            log_time
            uninstall_unnecessary
            log_time
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done


