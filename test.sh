#!/bin/bash
setup_path="$(pwd)"
#create startup executables
bash -c 'cat > ./webapi.service' << EOF
[Unit]
Description=API PPP Dial Service
Requires=network.target
After=network.target

[Service]
WorkingDirectory=$setup_path/WEBAPI
ExecStart=$(which node) index.js
Restart=always
# Restart service after 10 seconds if node service crashes
RestartSec=10
# Output to syslog
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=nodejs-pppd-dial
[Install]
WantedBy=multi-user.target
EOF
