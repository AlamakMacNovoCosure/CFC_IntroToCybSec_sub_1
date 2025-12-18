# README – Home Network Mapping and Analysis Project.

## Overview

This project is a three-phase security assessment designed to map an internal network, gather external intelligence on public-facing assets, and automate system diagnostics using Bash scripting.

The README explains the goals, required tools, step‑by‑step workflow, and expected outputs so the lab can be repeated or adapted to other home networks.

## Phase 1 – Network Mapping
### Objective: Create a comprehensive survey of the internal network terrain.
  - Device Discovery: Identify all active devices, including names, internal IP addresses, and MAC addresses.
  - Hardware Profiling: Identify MAC vendors (OUI) and determine connection types (Ethernet vs. Wireless).
  - Infrastructure Audit: Locate the Router (Internal/External IPs), DNS, and DHCP servers.
  - Operating Systems: Identify the OS and version for every discovered device.
  - ISP Identification: Confirm the active Internet Service Provider.
  - Visual Representation: Construct a network schema using diagrams.net (formerly draw.io).

#### Phase 1 focuses on identifying and documenting devices and infrastructure inside the home network.

<img width="882" height="753" alt="Home_Network_Diagram 2025-11-28 044717" src="https://github.com/user-attachments/assets/6c88ed57-9972-4056-a86c-1673dfed6bec" />

| Device Name         | IP Address       | MAC Address         | OS / Version                 | Vendor (MAC prefix) | Host Name        | Notes            |
|---------------------|------------------|---------------------|------------------------------|---------------------|------------------|------------------|
| btk-w09.lan         | 192.168.87.70    | —                   | Harmony OS 3.1.0             | —                   | —                | —                |
| nothing-phone-2a.lan| 192.168.87.72    | 4a:18:a2:xx:xx:xx   | Android 15                   | 4A:18:A2            | —                | —                |
| pixel-18a.lan       | 192.168.87.74    | —                   | Android 15                   | —                   | —                | —                |
| laptop-iqaboh8d.lan | 192.168.87.78    | 90:ca:fa:68:72:1b   | Windows 11 Home 10.0.26200   | 90:CA:FA            | LAPTOP-IQABOH8D  | Microsoft Corp.  |
| suunto-1310.lan     | 192.168.87.79    | —                   | —                            | —                   | —                | —                |


## Phase 2: External Intel Gathering
### Objective: Analyze the network’s public footprint and operational security.
  - Public Reconnaissance: Use Shodan to audit the public IP and WHOIS to identify registered ownership.
  - Traffic Analysis: Sniff network traffic to identify three active protocols.
  - Protocol Documentation: For each protocol, document its specific usage and associated port numbers.

#### Phase 2 examines the network’s public exposure and internal traffic characteristics.

Perform the following tasks: 

<img width="1338" height="255" alt="shodan_search 2025-11-27 230452" src="https://github.com/user-attachments/assets/903bebac-88fc-42ba-86ba-0d9f421c43b6" />

1) Shodan lookup of the public IP:  
   - Search for the public IP and document which services, ports, or device fingerprints (if any) are visible.  
   - Summarize findings, noting whether the home network appears directly exposed or mostly hidden behind NAT.
     

2) WHOIS lookup of the public IP:
   
<img width="1896" height="3133" alt="Screenshot 2025-11-27 at 23-08-58 Whois IP 116 88 126 144" src="https://github.com/user-attachments/assets/08846fd1-7fbb-4e35-8056-f4a1a26e4397" /> 
     

3) Network sniffing and protocol identification:
   - Capture traffic on the home network using a packet sniffer (e.g., Wireshark).
   - Identify at least three protocols observed in the capture.
   - Examples as follows:
     
     - DNS – for translating domain names to IP addresses; typically uses UDP 53 (sometimes TCP 53).
  
<img width="1201" height="787" alt="dns_port 2025-11-27 225626" src="https://github.com/user-attachments/assets/ae02e971-d2bd-4c87-93cd-1f1fd2183640" />

    - HTTP/HTTPS – for web traffic; typically uses TCP 80 for HTTP and TCP 443 for HTTPS.
            
<img width="1197" height="787" alt="http_port 2025-11-27 225446" src="https://github.com/user-attachments/assets/c90e020e-7173-473f-8fe8-79b151b4b3fe" />

    - NBNS – for NETBios Name Service; typically uses UDP 137 (server) and UDP 137 (client).
            
<img width="1203" height="791" alt="nbns_port 2025-11-27 225120" src="https://github.com/user-attachments/assets/f94fcfd4-8d28-4ba9-836e-908b045be46c" />


4) Protocol Documentation

| Protocol | Usage                                   | Port(s)         | Transport | Encryption Typical? |  
  |----------|---------------------------------------|-----------------|-----------|----------------------|  
  | DNS      | DNS acts as the internet's phonebook, translating human-friendly domain names (like google.com) into numerical IP addresses so computers can locate and connect to websites.  | 53                       | UDP/TCP   | DoT-DNS over TLS or DoH-DNS over HTTPS.        |  
  | HTTP     | HTTP is the foundation of the web, functioning as a request-response protocol that delivers website content (HTML/media), enables data transfer, and powers API communication between applications and servers.  | 80               | TCP       | TLS/SSL.                  | 
  | NBNS     | NBNS (NetBIOS Name Service) is a legacy protocol used to map computer names to IP addresses on a local network. It allows devices to find and communicate with each other for file and printer sharing, acting as an older, broadcast-based alternative to DNS.     | 137             | UDP       | No.           | 
       
## Phase 3: Automated System Info Extractor
### Objective: Develop a precision Bash script to extract real-time system analytics.
The script performs the following tasks:
- Network Identity: Fetches Public IP and Private IP (Interface-specific).
- Hardware Identity: Displays the MAC address with security masking.
- Performance Metrics: Captures CPU usage for the top 5 processes and total/available memory.
- Service Audit: Lists all active system services and their current status.
- Storage Analysis: Locates the top 10 largest files within the /home directory.

### Technical Requirements & Tools
- Reconnaissance: nmap, arp -a, shodan.io, viewdns.info.
- Scripting: Bash (using curl, ip addr, top, ps, du, find).
- Traffic Analysis: tcpdump or Wireshark.
- Documentation: A PDF report including a network schema and screenshots of all command outputs.

### Project Deliverables
1. Bash Script: A commented .sh file following clean coding standards.
2. PDF Report: Documentation of methodology, objectives, and network mapping results.
3. Presentation Video: A <5-minute .mp4 walkthrough of the code and project outcomes (with webcam enabled).

