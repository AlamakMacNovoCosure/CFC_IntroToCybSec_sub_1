"# CFC_IntroToCybSec_sub_1" 
README – Home Network Mapping and Analysis Project.

## Overview

This project documents a home network in two phases:  
- Phase 1 maps all internal devices and network services.  
- Phase 2 collects external footprint information and analyzes network traffic using standard tools.
  
The README explains the goals, required tools, step‑by‑step workflow, and expected outputs so the lab can be repeated or adapted to other home networks.

## Objectives

- Create a detailed map of every device on the home network, including addressing, connectivity, and platform details.
- Identify DNS, DHCP, router, and ISP information used to provide network and internet access.
- Assess the public exposure of the home network using IP intelligence (Shodan, WHOIS).
- Capture and analyze network traffic to identify at least three commonly used protocols, their purposes, and ports.

## Phase 1 – Network Mapping

Phase 1 focuses on identifying and documenting devices and infrastructure inside the home network.

<img width="882" height="753" alt="Home_Network_Diagram 2025-11-28 044717" src="https://github.com/user-attachments/assets/6c88ed57-9972-4056-a86c-1673dfed6bec" />

| Device Name         | IP Address       | MAC Address         | OS / Version                 | Vendor (MAC prefix) | Host Name        | Notes            |
|---------------------|------------------|---------------------|------------------------------|---------------------|------------------|------------------|
| btk-w09.lan         | 192.168.87.70    | —                   | Harmony OS 3.1.0             | —                   | —                | —                |
| nothing-phone-2a.lan| 192.168.87.72    | 4a:18:a2:xx:xx:xx   | Android 15                   | 4A:18:A2            | —                | —                |
| pixel-18a.lan       | 192.168.87.74    | —                   | Android 15                   | —                   | —                | —                |
| laptop-iqaboh8d.lan | 192.168.87.78    | 90:ca:fa:68:72:1b   | Windows 11 Home 10.0.26200   | 90:CA:FA            | LAPTOP-IQABOH8D  | Microsoft Corp.  |
| suunto-1310.lan     | 192.168.87.79    | —                   | —                            | —                   | —                | —                |

Collect and record for every device:  
- IP address (IPv4), as assigned on the local network.  
- MAC address and vendor (first 3 blocks only, e.g. 12:4F:C2:XX:XX:XX).  
- Device name/hostname (e.g., “LivingRoom-TV”, “Laptop‑Alice”).  
- Connection type: Ethernet or Wireless.  
- Operating system and version (e.g., Windows 11, Android 14, iOS 18, etc.).

Collect and record for the network:  
- Router internal (LAN) IP address.  
- Router external (public) IP address, formatted with each dot wrapped in brackets, for example: 10[.]123[.]123[.]123 and with only the last octet shown where specified (e.g., XXX[.]XXX[.]XXX[.]123).  
- DNS server IP address(es) used by your devices.  
- DHCP server IP address in the network (often the router).  
- Internet Service Provider (ISP) name.

The final deliverable for Phase 1 is the diagram above that:  
- Shows an “Internet” cloud linked to our ISP and then to our home router.  
- Shows the router connected to wireless access points.  
- Shows all devices with their required attributes (IP, truncated MAC, name, connection type, OS/version, vendor).

## Phase 2 – Information Collection and Analysis

Phase 2 examines the network’s public exposure and internal traffic characteristics.

Perform the following tasks: 

<img width="1338" height="255" alt="shodan_search 2025-11-27 230452" src="https://github.com/user-attachments/assets/903bebac-88fc-42ba-86ba-0d9f421c43b6" />

1) Shodan lookup of your public IP:  
   - Search your public IP and document which services, ports, or device fingerprints (if any) are visible.  
   - Summarize findings, noting whether the home network appears directly exposed or mostly hidden behind NAT.
     

2) WHOIS lookup of your public IP:
   
<img width="1896" height="3133" alt="Screenshot 2025-11-27 at 23-08-58 Whois IP 116 88 126 144" src="https://github.com/user-attachments/assets/08846fd1-7fbb-4e35-8056-f4a1a26e4397" /> 

   - Query WHOIS for your public IP block.  
   - Record the registered organization (usually the ISP), geographic region, and presence of abuse/contact information.  
   - Note that this registration is typically at provider level, not personal identity.
     

4) Network sniffing and protocol identification:
   - Capture traffic on the home network using a packet sniffer (e.g., Wireshark).  
   - Identify at least three protocols observed in the capture. Common examples include:
       
     - DNS – for translating domain names to IP addresses; typically uses UDP 53 (sometimes TCP 53).
       
<img width="1201" height="787" alt="dns_port 2025-11-27 225626" src="https://github.com/user-attachments/assets/ae02e971-d2bd-4c87-93cd-1f1fd2183640" />
      
         
     - HTTP/HTTPS – for web traffic; typically uses TCP 80 for HTTP and TCP 443 for HTTPS.
            
<img width="1197" height="787" alt="http_port 2025-11-27 225446" src="https://github.com/user-attachments/assets/c90e020e-7173-473f-8fe8-79b151b4b3fe" />

         
     - NBNS – for NETBios Name Service; typically uses UDP 137 (server) and UDP 137 (client).
            
<img width="1203" height="791" alt="nbns_port 2025-11-27 225120" src="https://github.com/user-attachments/assets/f94fcfd4-8d28-4ba9-836e-908b045be46c" />




| Protocol | Usage                                   | Port(s)         | Transport | Encryption Typical? |  
  |----------|-----------------------------------------|-----------------|-----------|----------------------|  
  | DNS      | Name resolution for domains.           | 53              | UDP/TCP   | DoT-DNS over TLS or DoH-DNS over HTTPS.        |  
  | HTTP     | Unencrypted web/application traffic.   | 80              | TCP       | TLS/SSL.                  |  
  | NBNS    | Encrypted web/application traffic.     | 137             | UDP       | No.           | 
       
   - For each chosen protocol, provide:  
     - A short explanation of its purpose on the network.  
     - The port number(s) and transport protocol (TCP/UDP) used.  
     - A brief note on whether the protocol is typically encrypted or not.

The final deliverable for Phase 2 is a short written section that:  
- Summarizes Shodan and WHOIS results for the public IP.  
- Lists three observed protocols with their usage and port information.  
- Connects these observations back to normal home network operations (e.g., web browsing, name resolution, IP assignment).

## Deliverables

Include the following artifacts:

- Network Map Diagram (image or PDF):  
  - Logical map of internet → ISP → router → internal devices and links.  
  - Each device annotated with IP, truncated MAC, connection type, OS/version, and name.

- Device Inventory Table (e.g., in the report or README):  

  | Device Name | IP Address       | MAC (first 3 blocks) | Connection | OS & Version | Vendor | Notes |  
  |------------|------------------|----------------------|------------|-------------|--------|-------|  
  | Example    | 192.168.1.10     | 12:4F:C2:XX:XX:XX    | Wi‑Fi      | Windows 11  | Vendor | PC   | 

- External Footprint Summary:  
  - 1–2 paragraphs summarizing Shodan and WHOIS findings for the public IP, using anonymized IP format (10[.]x[.]x[.]x style).

- Protocol Analysis Table:  

  | Protocol | Usage                                   | Port(s)         | Transport | Encryption Typical? |  
  |----------|-----------------------------------------|-----------------|-----------|----------------------|  
  | DNS      | Name resolution for domains.           | 53              | UDP/TCP   | DoT-DNS over TLS or DoH-DNS over HTTPS.        |  
  | HTTP     | Unencrypted web/application traffic.   | 80              | TCP       | TLS/SSL.                  |  
  | NBNS    | Encrypted web/application traffic.     | 137             | UDP       | No.           | 

## Usage

- Follow Phase 1 steps first to enumerate and map devices, then create the network diagram and inventory table.
- Complete Phase 2 by performing Shodan and WHOIS checks on the public IP and capturing live traffic to identify protocols and ports.
- Update the README and accompanying report with your actual findings, ensuring all IPs are anonymized as required and that no copyrighted materials (including screenshots from third‑party sites) are reproduced verbatim.
