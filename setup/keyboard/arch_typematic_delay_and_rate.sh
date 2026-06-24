#!/bin/bash
#https://wiki.archlinux.org/title/Linux_console/Keyboard_configuration#Adjusting_typematic_delay_and_rate

set -euo pipefail

sudo cat > /etc/systemd/system/kbdrate.service <<- '_EOF_'
	[Unit]
	Description=Keyboard repeat rate in tty.

	[Service]
	Type=oneshot
	RemainAfterExit=yes
	StandardInput=tty
	StandardOutput=tty
	ExecStart=/usr/bin/kbdrate --silent --delay 200 --rate 60

	[Install]
	WantedBy=multi-user.target
	_EOF_

# Then start/enable the kbdrate.service systemd service.
#sudo systemctl start kbdrate.service
sudo systemctl is-enabled kbdrate.service || sudo systemctl enable kbdrate.service
