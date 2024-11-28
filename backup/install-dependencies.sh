#!/bin/bash

set -e

# Path to the requirements.txt file (mounted via ConfigMap or directly copied)
REQ_FILE="/tmp/requirements.txt"

# Check if the file exists
if [ ! -f "$REQ_FILE" ]; then
  echo "Error: $REQ_FILE not found!"
  exit 1
fi

# Install dependencies
pip install -r "$REQ_FILE"
