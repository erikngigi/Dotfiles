#!/bin/bash

PUBLIC_IP=$(curl -s https://api.ipify.org)

echo "Your public IP address is: $PUBLIC_IP"
