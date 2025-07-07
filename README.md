# rpi-print-server

This repository contains an Ansible playbook to configure a Raspberry Pi 2 Model B as a print server for a Brother HL3170CDW printer. The Pi uses Wi-Fi (`wlan0`) to receive print jobs from the LAN and connects to the printer over an isolated Ethernet network (`eth0`).

## Features

- Static IP configuration for the printer network
- Minimal DHCP service using dnsmasq
- CUPS setup with a shared queue
- Samba sharing for Windows clients
- AirPrint advertisement via Avahi
- Optional firewall rules to prevent forwarding between `wlan0` and `eth0`

## Usage

Edit your inventory to include a host in the `printserver` group and run:

```bash
ansible-playbook -i inventory site.yml
```

## Quick install

Download the packaged installer from the latest release and run it directly on the Pi:

```bash
curl -L https://github.com/ke4roh/rpi-print-server/releases/download/r1.1/printserver-install-1.1.run | bash
```

The roles assume the printer will be reachable at `192.168.3.2` on the private subnet.
