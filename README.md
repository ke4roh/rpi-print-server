# rpi-print-server

This repository contains an Ansible playbook to configure a Raspberry Pi 2 Model B as a print server for a Brother HL3170CDW printer. The Pi receives print jobs over the network and connects to the printer via USB.

## Features

- CUPS setup with a shared queue for a USB-connected printer
- Printer drivers installed automatically (brlaser with Gutenprint fallback)
- Samba sharing for Windows clients
- AirPrint advertisement via Avahi

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
