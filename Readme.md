
## Note
* Install:
```sh
sudo apt-get install -y hostapd dnsmasq ppp minicom iptables
```


## Problem 
---
### `[1] Hostapd:  'wlan0: STA 24:43:e2:50:31:ff IEEE 802.11: disassociated'`

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

### `[2]. pppd dont replace defaultroute `

This problem is a known bug of pppd at [link](https://github.com/ppp-project/ppp/issues/115)

That cause the system don't use ppp0 as default routing for ethernet. By default system may use eth0 or wlan0 as default route for ethernet.

* To check route 
```sh
ip route show
```


IF we want to use ppp0 as default internet source of system in case :   
```sh
                  |--------------Raspbery PI------------|
                  |                                     | 
client-phone ---->| Wifi AP ( wlan0) -----nat----> ppp0 |---> Dial UP Ethernet
                  |                                     |
                  |-------------------------------------|
```

we need to set ppp0 as default internet route 
```sh
sudo ip route add default dev ppp0
```
`Note that: this command can only work if  the interface ppp0 is established and availble. When dial OK and setup the pppd OK. Otherwise it will show the error can not find ppp0 interface`

* As a workaraound, create executable shell script at the end of: /etc/ppp/ip-up:
```sh
    route add default dev ppp0
```
 and and at the end of /etc/ppp/ip-down 
```sh
   route del default dev ppp0
```




######
Reference
https://cdn-reichelt.de/documents/datenblatt/G100/8560C1_MANUAL.pdf






