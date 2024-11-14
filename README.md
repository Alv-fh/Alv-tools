# Alv-tools - Pentesting Toolkit

**Alv-tools** es una herramienta de pentesting creada en Bash, diseñada para realizar tareas de escaneo y enumeración en redes e IPs específicas. Su objetivo es proporcionar información sobre el objetivo (Target) para facilitar la fase de reconocimiento.

---

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Demo](#demo)
   - [Option -h, --help](#-h---help)
   - [Option -p, --portscan](#-p---portscan)
   - [Option -s, --serviceenum](#-s---serviceenum)
   - [Option -a, --arp-scan](#-a---arp-scan)
   - [Option -o, --osdetect](#-o---osdetect)
   - [Option -f, --fullscan](#-f---fullscan)

---

## Features

Alv-tools allows for several common pentesting tasks:

- Port scanning
- Subnet ping sweep
- Service enumeration on specific IPs
- Network scanning (ARP scan)
- Operating system and version detection
- Comprehensive scan that includes ports, service versions, operating system, and domain name

## Installation

```bash
git clone https://github.com/Alv-fh/Alv-tools.git
cd Alv-tools
sudo bash alv-tools -h
```

## Usage

```bash
sudo bash alv-tools.sh [OPTION] [TARGET]
```

## Demo

### -h, --help

![help](https://github.com/user-attachments/assets/63c6d66b-8f94-45fc-9fcf-f69cc3046ae0)

### -p, --portscan

![ports](https://github.com/user-attachments/assets/e2d6f38e-6d6e-44b6-9e7c-7c63a61bd9bf)

### -s, --serviceenum

![services](https://github.com/user-attachments/assets/6ff91b9e-d976-4227-a505-da37606925bc)

### -a, --arp-scan

![arp-scan](https://github.com/user-attachments/assets/02c6dfdf-9037-45af-acb2-85eb3c7dbaee)

### -o, --osdetect

![os](https://github.com/user-attachments/assets/e85f41b5-a27e-4ed7-9172-a7a5ed3c8ba4)

### -f, --fullscan

![fullscan](https://github.com/user-attachments/assets/97d8acf1-524c-43d3-8e52-7af393450edd)

