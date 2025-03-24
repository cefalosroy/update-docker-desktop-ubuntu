#!/bin/bash

# Docker Desktop latest version update script for Ubuntu

# Step 1: Remove old docker-desktop if exists
echo "Removing old Docker Desktop (if exists)..."
sudo apt remove -y docker-desktop

# Step 2: Get the latest download URL dynamically (you can also hardcode if preferred)
echo "Fetching latest Docker Desktop version info..."
LATEST_DEB_URL=$(curl -s https://desktop.docker.com/linux/main/amd64/appcast.xml | grep -oP 'https://desktop.docker.com/linux/main/amd64/[^"]+deb' | head -n 1)

if [ -z "$LATEST_DEB_URL" ]; then
  echo "Could not find the latest download URL! Exiting."
  exit 1
fi

echo "Latest Docker Desktop URL: $LATEST_DEB_URL"

# Step 3: Download the .deb package
echo "Downloading Docker Desktop latest version..."
wget -O docker-desktop-latest.deb "$LATEST_DEB_URL"

# Step 4: Install the downloaded package
echo "Installing Docker Desktop..."
sudo apt install -y ./docker-desktop-latest.deb

# Step 5: Cleanup
rm docker-desktop-latest.deb

# Step 6: Verify
echo "Checking Docker version..."
docker --version
docker compose --version

echo "Docker Desktop Update Completed Successfully ✅"

