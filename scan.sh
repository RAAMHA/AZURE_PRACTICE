#!/bin/bash
set -e

IMAGE_TAG="flask-multistage-app:latest"
echo "[+] Building Docker image..."
docker build -t $IMAGE_TAG .

echo "[+] Installing Trivy..."
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin

echo "[+] Scanning image with Trivy..."
trivy image --exit-code 1 --severity HIGH,CRITICAL --format table $IMAGE_TAG
