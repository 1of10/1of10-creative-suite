#!/usr/bin/env bash

set -e

SNAPSHOT_FILE=$(ls /*snapshot*.json 2>/dev/null | head -n 1)

if [ -z "$SNAPSHOT_FILE" ]; then
    echo "runpod-worker-comfy: No snapshot file found. Exiting..."
    exit 0
fi

echo "runpod-worker-comfy: restoring snapshot: $SNAPSHOT_FILE"

# Installer les dépendances système pour OpenCV
apt-get update && apt-get install -y libgl1 libglib2.0-0 libsm6 libxext6 libxrender-dev

# Installer OpenCV
pip install opencv-python==4.10.0.84 opencv-python-headless==4.10.0.84 --no-cache-dir

# Restaurer le snapshot
comfy --workspace /comfyui node restore-snapshot "$SNAPSHOT_FILE" --pip-non-url

echo "runpod-worker-comfy: restored snapshot file: $SNAPSHOT_FILE"