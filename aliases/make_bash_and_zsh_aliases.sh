#!/bin/bash

echo "alias .alias='vi ~/.oh-my-zsh/custom/aliases.zsh > /dev/null'" | tee -a new_aliases.zsh > /dev/null
echo "alias autoremove='sudo apt autoremove -y'" | tee -a new_aliases.zsh > /dev/null
echo "alias chkrootkit='sudo chkrootkit'" | tee -a new_aliases.zsh > /dev/null
echo "alias chmod='sudo chmod'" | tee -a new_aliases.zsh > /dev/null
echo "alias chmodworldr='sudo chmod -R 700 *'" | tee -a new_aliases.zsh > /dev/null
echo "alias chmodworld='sudo chmod 700 *'" | tee -a new_aliases.zsh > /dev/null
echo "alias chown='sudo chown'" | tee -a new_aliases.zsh > /dev/null
echo "alias chownworldr='sudo chown -R ${USER}:${USER} *'" | tee -a new_aliases.zsh > /dev/null
echo "alias chownworld='sudo chown ${USER}:${USER} *'" | tee -a new_aliases.zsh > /dev/null
echo "alias con_down='nmcli con down id node-us-156.protonvpn.net.tcp'" | tee -a new_aliases.zsh > /dev/null
echo "alias con_up='nmcli con up id node-us-156.protonvpn.net.tcp'" | tee -a new_aliases.zsh > /dev/null
echo "alias cp='cp -i'" | tee -a new_aliases.zsh > /dev/null
echo "alias desc='cat ~/notes.txt/syntax/gen.txt'" | tee -a new_aliases.zsh > /dev/null
echo "alias dirfix='vi ~/.config/user-dirs.dirs'" | tee -a new_aliases.zsh > /dev/null
echo "alias fix='git branch -M main; git push -u origin main'" | tee -a new_aliases.zsh > /dev/null
echo "alias flip='python3 ~/notes.txt/python/scripts/coinFlip.py'" | tee -a new_aliases.zsh > /dev/null
echo "alias fullupdate='update -y; upgrade -y; autoremove; updatedb'" | tee -a new_aliases.zsh > /dev/null
echo "alias goprivate='cd ~/notes.txt/git/private'" | tee -a new_aliases.zsh > /dev/null
echo "alias gp='git branch -M main; git push -u origin main'" | tee -a new_aliases.zsh > /dev/null
echo "alias GUI='kex --win -s'" | tee -a new_aliases.zsh > /dev/null
echo "alias install='sudo apt install'" | tee -a new_aliases.zsh > /dev/null
echo "alias ip='ip -br -c a'" | tee -a new_aliases.zsh > /dev/null
echo "alias iptables='sudo iptables'" | tee -a new_aliases.zsh > /dev/null
echo "alias iptadd='python3 ~/notes.txt/scripts/iptables_add_port.py'" | tee -a new_aliases.zsh > /dev/null
echo "alias iptdel='sudo iptables -D INPUT 1'" | tee -a new_aliases.zsh > /dev/null
echo "alias iptrules='iptables -L --line-numbers'" | tee -a new_aliases.zsh > /dev/null
echo "alias jadx-gui=/opt/jadx/build/jadx/bin/jadx-gui" | tee -a new_aliases.zsh > /dev/null
echo "alias live='live-server --browser=google-chrome'" | tee -a new_aliases.zsh > /dev/null
echo "alias load_req='python -m pip freeze > requirements.txt'" | tee -a new_aliases.zsh > /dev/null
echo "alias locate='sudo locate'" | tee -a new_aliases.zsh > /dev/null
echo "alias lsblknosnap='lsblk | grep -v /snap'" | tee -a new_aliases.zsh > /dev/null
echo "alias lynis='sudo lynis audit system > ~/.lynis.txt'" | tee -a new_aliases.zsh > /dev/null
echo "alias m8b='python3 ~/notes.txt/python/scripts/magic8Ball2.py'" | tee -a new_aliases.zsh > /dev/null
echo "alias mecp='cp -i'" | tee -a new_aliases.zsh > /dev/null
echo "alias memkdir='mkdir'" | tee -a new_aliases.zsh > /dev/null
echo "alias mount='sudo mount'" | tee -a new_aliases.zsh > /dev/null
echo "alias mv='mv -i'" | tee -a new_aliases.zsh > /dev/null
echo "alias net_info='sudo netstat --listening --program --numeric --tcp --udp --extend'" | tee -a new_aliases.zsh > /dev/null
echo "alias nexus='emulator -avd Nexus_5_API_23 &'" | tee -a new_aliases.zsh > /dev/null
echo "alias p_10='. ~/notes.txt/scripts/p_10.sh' " | tee -a new_aliases.zsh > /dev/null
echo "alias p_9='. ~/notes.txt/scripts/p_9.sh'" | tee -a new_aliases.zsh > /dev/null
echo "alias password_gen='python3 ~/notes.txt/git/Python/CLI_password_generators/password_gen.py'" | tee -a new_aliases.zsh > /dev/null
echo "alias puller='emulator -avd Google_Play_Puller &'" | tee -a new_aliases.zsh > /dev/null
echo "alias rdp_py='python3 ~/notes.txt/script/rdp.py'" | tee -a new_aliases.zsh > /dev/null
echo "alias refreshfish='source ~/.config/fish/config.fish'" | tee -a new_aliases.zsh > /dev/null
echo "alias refreshzsh='source ~/.zshrc'" | tee -a new_aliases.zsh > /dev/null
echo "alias remove='sudo apt remove'" | tee -a new_aliases.zsh > /dev/null
echo "alias rkhunter='sudo rkhunter'" | tee -a new_aliases.zsh > /dev/null
echo "alias rm='sudo rm -i'" | tee -a new_aliases.zsh > /dev/null
echo "alias sel_start='cat ~/notes.txt/syntax/selenium_start.txt'" | tee -a new_aliases.zsh > /dev/null
echo "alias service='sudo service'" | tee -a new_aliases.zsh > /dev/null
echo "alias start_emulator='sudo chown ${USER}:${USER} /dev/kvm'" | tee -a new_aliases.zsh > /dev/null
echo "alias systemctl='sudo systemctl'" | tee -a new_aliases.zsh > /dev/null
echo "alias ufw='sudo ufw'" | tee -a new_aliases.zsh > /dev/null
echo "alias umount='sudo umount'" | tee -a new_aliases.zsh > /dev/null
echo "alias updatedb='sudo updatedb'" | tee -a new_aliases.zsh > /dev/null
echo "alias update='sudo apt update'" | tee -a new_aliases.zsh > /dev/null
echo "alias upgrade='sudo apt upgrade'" | tee -a new_aliases.zsh > /dev/null
echo "alias virt='cat ~/notes.txt/syntax/python_virtenv_setup.py'" | tee -a new_aliases.zsh > /dev/null
echo "alias virt_start='sudo virsh net-start default'" | tee -a new_aliases.zsh > /dev/null
echo "alias wifishownearby='nmcli dev wifi list'" | tee -a new_aliases.zsh > /dev/null
echo "alias world='chownworld ; chmodworld'" | tee -a new_aliases.zsh > /dev/null
echo "alias worldr='chownworldr ; chmodworldr'" | tee -a new_aliases.zsh > /dev/null

#copy aliases to ~/.bash_aliases
#cp new_aliases.zsh > ~/.bash_aliases

if [ "$USER" != root ]; then
  echo -e "~~ To activate aliases for bash run ~~\n\n ~ source /home/${USER}/.bash_aliases\n\n~~ or ~~\n\n ~ source ~/.bash_aliases\n\n~~ If xclip is installed then press SHIFT+CRTL+V ~~\n\n~~ For root ~~\n\n ~ su -\n\n ~ source ~/.bash_aliases"
  #if xclip is installed then output to clipboard
  if command -v xclip > /dev/null; then
    echo "source /home/${USER}/.bash_aliases" | xclip -selection clipboard
  fi
fi

