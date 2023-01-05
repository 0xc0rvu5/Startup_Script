#!/bin/bash

echo -e "#!/bin/fish\n" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s .alias 'vi ~/.oh-my-zsh/custom/aliases.zsh > /dev/null'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s autoremove 'sudo apt autoremove -y'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s chkrootkit 'sudo chkrootkit'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s chmod 'sudo chmod'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s chmodworldr 'sudo chmod -R 700 *'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s chmodworld 'sudo chmod 700 *'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s chown 'sudo chown'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s chownworldr 'sudo chown -R ${USER}:${USER} *'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s chownworld 'sudo chown ${USER}:${USER} *'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s con_down 'nmcli con down id node-us-156.protonvpn.net.tcp'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s con_up 'nmcli con up id node-us-156.protonvpn.net.tcp'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s cp 'cp -i'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s desc 'cat ~/notes.txt/syntax/gen.txt'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s dirfix 'vi ~/.config/user-dirs.dirs'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s fix 'git branch -M main; git push -u origin main'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s flip 'python3 ~/notes.txt/python/scripts/coinFlip.py'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s fullupdate 'update -y; upgrade -y; autoremove; updatedb'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s goprivate 'cd ~/notes.txt/git/private'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s gp 'git branch -M main; git push -u origin main'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s GUI 'kex --win -s'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s install 'sudo apt install'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s ip 'ip -br -c a'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s iptables 'sudo iptables'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s iptadd 'python3 ~/notes.txt/scripts/iptables_add_port.py'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s iptdel 'sudo iptables -D INPUT 1'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s iptrules 'iptables -L --line-numbers'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s jadx-gui /opt/jadx/build/jadx/bin/jadx-gui" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s live 'live-server --browser google-chrome'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s load_req 'python -m pip freeze > requirements.txt'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s locate 'sudo locate'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s lsblknosnap 'lsblk | grep -v /snap'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s lynis 'sudo lynis audit system > ~/.lynis.txt'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s m8b 'python3 ~/notes.txt/python/scripts/magic8Ball2.py'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s mecp 'cp -i'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s memkdir 'mkdir'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s mount 'sudo mount'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s mv 'mv -i'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s net_info 'sudo netstat --listening --program --numeric --tcp --udp --extend'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s nexus 'emulator -avd Nexus_5_API_23 &'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s p_10 '. ~/notes.txt/scripts/p_10.sh' " | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s p_9 '. ~/notes.txt/scripts/p_9.sh'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s password_gen 'python3 ~/notes.txt/git/Python/CLI_password_generators/password_gen.py'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s puller 'emulator -avd Google_Play_Puller &'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s rdp_py 'python3 ~/notes.txt/script/rdp.py'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s refreshfish 'source ~/.config/fish/config.fish'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s refreshzsh 'source ~/.zshrc'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s remove 'sudo apt remove'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s rkhunter 'sudo rkhunter'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s rm 'rm -i'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s sel_start 'cat ~/notes.txt/syntax/selenium_start.txt'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s service 'sudo service'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s start_emulator 'sudo chown ${USER}:${USER} /dev/kvm'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s systemctl 'sudo systemctl'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s ufw 'sudo ufw'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s umount 'sudo umount'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s updatedb 'sudo updatedb'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s update 'sudo apt update'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s upgrade 'sudo apt upgrade'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s virt 'cat ~/notes.txt/syntax/python_virtenv_setup.py'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s virt_start 'sudo virsh net-start default'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s wifishownearby 'nmcli dev wifi list'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s world 'chownworld ; chmodworld'" | tee -a new_fish_aliases.fish > /dev/null
echo "alias -s worldr 'chownworldr ; chmodworldr'" | tee -a new_fish_aliases.fish > /dev/null
echo -e "\necho -e '~~ Current shell will have aliases activated ~~\n\n~~ Find alias files @ ~~\n\n~ ls ~/.config/fish/functions'" | tee -a new_fish_aliases.fish > /dev/null


#change owner permissions to executable
chmod 700 new_fish_aliases.fish

if [ "$USER" != root ]; then
  echo -e "!! Now executable !!\n\n~ new_fish_aliases.fish\n\n~~ After fish installation run ~~\n\n~ fish new_fish_aliases.fish\n\n~~ If xclip is installed then press SHIFT+CRTL+V ~~\n\n"
  #if xclip is installed then output to clipboard
  if command -v xclip > /dev/null; then
    echo "fish new_fish_aliases.fish" | xclip -selection clipboard
  fi
fi
