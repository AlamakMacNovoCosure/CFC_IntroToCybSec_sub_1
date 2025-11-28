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

The final deliverable for Phase 1 is a diagram and/or table that:  
- Shows an “Internet” cloud linked to your ISP and then to your home router.  
- Shows the router connected to switches and wireless access points if present.  
- Shows all devices with their required attributes (IP, truncated MAC, name, connection type, OS/version, vendor).

## Phase 2 – Information Collection and Analysis

Phase 2 examines the network’s public exposure and internal traffic characteristics.

Perform the following tasks:  
1) Shodan lookup of your public IP:  
   - Search your public IP and document which services, ports, or device fingerprints (if any) are visible.  
   - Summarize findings, noting whether the home network appears directly exposed or mostly hidden behind NAT.

2) WHOIS lookup of your public IP:  
   - Query WHOIS for your public IP block.  
   - Record the registered organization (usually the ISP), geographic region, and presence of abuse/contact information.  
   - Note that this registration is typically at provider level, not personal identity.

3) Network sniffing and protocol identification:  
   - Capture traffic on the home network using a packet sniffer (e.g., Wireshark).  
   - Identify at least three protocols observed in the capture. Common examples include:  
     - DNS – for translating domain names to IP addresses; typically uses UDP 53 (sometimes TCP 53).  
     - HTTP/HTTPS – for web traffic; typically uses TCP 80 for HTTP and TCP 443 for HTTPS.  
     - DHCP – for automatic IP address assignment; typically uses UDP 67 (server) and UDP 68 (client).
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
