#!/bin/bash

# 1. Update the 'System'
echo "Starting System Update..."
# sudo apt-get update  ← commented out for local safety

# 2. Create a Directory Structure for a Web App
echo "Creating Application Folders..."
mkdir -p web_app/logs
mkdir -p web_app/config

# 3. Create a dummy config file
echo "server_port=8080" > web_app/config/settings.conf

echo "--- Server Provisioning Complete ---"