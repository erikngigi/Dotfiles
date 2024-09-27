#!/bin/bash

# Get the IP address
ip_address=$(ifconfig eth0 | grep 'inet ' | awk '{print $2}')

# Print the IP address
echo "Your IP address is: $ip_address"
