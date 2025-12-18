#!/usr/bin/env bash

#Define colours for better ouyput visibility
GREEN='\033[0;32m'
RED='\033[0,31m'
NC='\033[0m' # No colour

echo -e "${GREEN}### Automated System Information Report ###${NC}"

## 3.1 Identify the system's public IP
echo "---------------------------------------------------------"
echo -e "${GREEN}3.1. Public IP Address:${NC}"
PUBLIC_IP=$(curl ipinfo.io) #icanhazip.com, api.ipify.org, ipinfo.io
if [ -n "$PUBLIC_IP" ]; then
    echo " $PUBLIC_IP"
else
    echo -e "${RED}  Could not determine public IP (network issue or curl not installed).${NC}"
fi


## 3.2. Identify the private IP address assigned to the system's network interface
echo "------------------------------------------------------"
echo -e "${GREEN}3.2. Private IP Address(es):${NC}"
# 'hostname -I' is generally a clean way to get local IPs.
PRIVATE_IPS=$(hostname -I)
if [ -n "$PRIVATE_IPS" ]; then
    echo "  $PRIVATE_IPS"
else
    echo -e "${RED}  Could not determine private IP address using hostname -I.${NC}"
    # Fallback using 'ip addr' if 'hostname -I' fails
    echo "  Attempting fallback with 'ip addr'..."
    ip addr show | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d/ -f1 | while read ip; do
        echo "  $ip"
    done
fi



## 3.3. Display the MAC address (masking sensitive portions for security)
echo "------------------------------------------------------"
echo -e "${GREEN}3.3. MAC Address (Masked):${NC}"
# Use 'ip addr' to get MAC address (labeled as 'link/ether') and mask last half
ip addr show | grep 'link/ether' | awk '{print $2}' | while read mac; do
    # Masking the last 3 octets with XX:XX:XX
    MASKED_MAC=$(echo "$mac" | sed 's/\(:[0-9a-fA-F]\{2\}\)\{3\}$/:XX:XX:XX/')
    echo "  $MASKED_MAC"
done

## 3.4. Display the percentage of CPU usage for the top 5 processes
echo "------------------------------------------------------"
echo -e "${GREEN}3.4. Top 5 CPU-intensive processes (% CPU, PID, Command):${NC}"
# 'ps' command is more script-friendly for this than 'top'.
# --sort=-%cpu sorts in descending order of CPU usage
# head -n 6 gets the header plus the top 5 results
ps -eo pcpu,pid,cmd --sort=-%cpu | head -n 6


## 3.5. Display memory usage statistics: total and available memory
echo "------------------------------------------------------"
echo -e "${GREEN}3.5. Memory Usage Statistics (Total and Available in MB):${NC}"
# 'free -m' displays memory stats in megabytes
# The 'awk' command specifically extracts total and available memory values
read -r _ TOTAL_MEM USED_MEM FREE_MEM SHARED_MEM BUFF_MEM AVAIL_MEM <<< $(free -m | grep Mem:)
echo "  Total Memory:   $TOTAL_MEM MB"
echo "  Available Memory: $AVAIL_MEM MB"


## 3.6. List active system services with their status
echo "------------------------------------------------------"
echo -e "${GREEN}3.6. Active System Services (Top 10):${NC}"
# 'systemctl list-units --type=service --state=active' is the modern command for systemd systems
if command -v systemctl &> /dev/null; then
    systemctl list-units --type=service --state=active --no-legend | head -n 10
else
    echo "  'systemctl' not found. This command is typically for systemd-based systems."
    echo "  You may need to use an alternative command like 'service --status-all' depending on your init system."
fi



## 3.7. Locate the Top 10 Largest Files in /home
echo "------------------------------------------------------"
echo -e "${GREEN}3.7. Top 10 Largest Files in /home:${NC}"
# 'find' locates files, 'du' calculates size, 'sort' orders by size, 'head' limits to top 10
# This command requires appropriate permissions to search all of /home.
find /home -type f -exec du -Sh {} + | sort -rh | head -n 10

echo "------------------------------------------------------"
echo -e "${GREEN}### Report Complete ###${NC}"

# Detailed Command Explanations
#Here are details for some of the key commands used:

#curl -s api.ipify.org: The curl command fetches data from a specified URL. The -s flag makes it run in silent mode(no progress meter or error messages). The service api.ipify.org returns just the plain text of your public IP address.
#ps -eo pcpu,pid,cmd --sort=-%cpu | head -n 6: The ps command is used for displaying information about running processes.
#   -e seilects all processes.
#   -o specifies the output format (percent CPU, Process ID, command).
#   --sort=-%cpu sorts in descending order based on CPU usage percentage.
#   head -n 6 takes the top 6 lines of output (the header plus the top 5 processes).
#free -m | grep Mem: | awk ...: The free -m command shows system memory usage in Megabytes. grep Mem: filters for the relevant line, and awk is used to parse the specific numeric fields for total and available memory.
#systemctl list-units --type=service --state=active: This command lists all active systemd services. It's the modern, preferred way to check service status on most contemporary Linux distributions.
#find /home -type f -exec du -Sh {} + | sort -rh | head -n 10:
#     find /home -type f looks for all regular files in the /home directory.
#     du -Sh calculates the disk usage in human-readable format (e.g., K, M, G).
#     sort -rh sorts the output numerically (-r reverses the order, -h understands human-readable sizes).
#     head -n 10 outputs only the top 10 largest entries.
