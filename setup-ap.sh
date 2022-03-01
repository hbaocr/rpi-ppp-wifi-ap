#!/bin/bash
setup_path="$(pwd)"

##########################################
echo "1. Install required services"
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y hostapd dnsmasq ppp minicom iptables python3

##########################################

echo "------->2. Stop auto service"
# don't  let it done  auto
# stop  current running instance
sudo systemctl stop dnsmasq.service
# disable restart service
sudo systemctl disable dnsmasq.service 
sudo systemctl stop hostapd
sudo systemctl unmask hostapd
sudo systemctl disable hostapd

sudo killall dnsmasq
sudo killall hostapd
#############################################
echo "------->3. Setup autohotspot service run once  at pwr on"
#create startup executables
sudo bash -c 'cat > /usr/bin/autohotspot.sh' << EOF
#!/bin/bash
cd "$setup_path/bin"
sudo ./wifi_ap_service_startup.sh
EOF
sudo chmod +x /usr/bin/autohotspot.sh

#############################################
echo "------->4. Enable AP Service"
sudo chmod +x "$setup_path/bin/wifi_ap_service_startup.sh"
sudo chmod +x "$setup_path/bin/start_fork_ap.sh"
sudo cp -f ./config_service/autohotspot.service /etc/systemd/system/autohotspot.service
sudo systemctl enable autohotspot.service
sudo systemctl start autohotspot.service

#############################################
echo "------->5. Modify ip-up and ip-down in /etc/ppp to set ethernet defaultroute to ppp when this interface up(dial ok)"
sudo cp -f "$setup_path/bin/ppp/ip-up" /etc/ppp/ip-up
sudo cp -f "$setup_path/bin/ppp/ip-down" /etc/ppp/ip-down
sudo chmod +x /etc/ppp/ip-up
sudo chmod +x /etc/ppp/ip-down

#############################################

echo "Reboot service"
sudo reboot


