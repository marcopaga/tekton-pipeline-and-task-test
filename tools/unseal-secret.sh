#!/bin/sh
set -e

if [ -z "$1" ]; then
    echo "Unseals a given sealed secret file in-place by retrieving the"
    echo "decrypted secret from the current k8s context."
    echo "Usage: unseal-secret.sh [FILE]"
    exit 1
fi

namespace="$(yq r "$1" 'metadata.namespace')"
name="$(yq r "$1" 'metadata.name')"

kubectl get secret -o yaml -n "$namespace" "$name" >"$1.unsealed"

yq r "$1.unsealed" data | while read -r entry; do
    key="$(echo "$entry" | cut -d':' -f1)"
    value="$(echo "$entry" | cut -d':' -f2 | tail -c+2 | base64 -d)"
    yq w -i "$1.unsealed" "stringData.[$key]" "$value"
done

yq d -i "$1.unsealed" data
yq d -i "$1.unsealed" metadata
yq w -i "$1.unsealed" "metadata.name" "$name"
yq w -i "$1.unsealed" "metadata.namespace" "$namespace"

mv "$1.unsealed" "$1"