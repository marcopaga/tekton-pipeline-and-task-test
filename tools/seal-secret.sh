#!/bin/sh
set -e

if [ -z "$1" ]; then
    echo "Seals a given secret file in-place using the current k8s context."
    echo "Usage: seal-secret.sh [FILE]"
    exit 1
fi

kubeseal -o yaml <"$1" >"$1.sealed"
mv "$1.sealed" "$1"