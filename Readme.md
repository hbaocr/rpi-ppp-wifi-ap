
## Note
* Install:
```sh
sudo apt-get install -y hostapd dnsmasq ppp minicom iptables
```


## Problem 
---
#### `[1] Hostapd:  'wlan0: STA 24:43:e2:50:31:ff IEEE 802.11: disassociated'`

That may cause wlan0  was already in STA mode and can not start AP mode.In STA the wlan0 is controlled by **wpa_supplicant** ==> To solve just kill wpa_supplicant and try to start hostapad on wlan0 :
```sh
# kill wpa_supplicant to release wlan0
sudo killall wpa_supplicant
# start AP on wlan0 ( configured by hostapd.conf)
sudo hostapd /etc/hostapd/hostapd.conf

```

This will temporary disable wpa_supplicant, to forbid wpa_supplicant run at next boot up --> disable wpa_supplicant service

```sh
sudo systemctl stop wpa_supplicant
sudo systemctl disable wpa_supplicant
```
---

