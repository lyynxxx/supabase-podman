#!/bin/bash
# Pull/Update all Supabase images for Podman
# Run periodically to keep images updated

set -e

echo "=== Pulling Supabase Images ==="
echo ""

IMAGES=(
    "docker.io/supabase/studio:2025.12.17-sha-43f4f7f"
    "docker.io/library/kong:2.8.1"
    "docker.io/supabase/gotrue:v2.184.0"
    "docker.io/postgrest/postgrest:v14.1"
    "docker.io/supabase/realtime:v2.68.0"
    "docker.io/supabase/storage-api:v1.33.0"
    "docker.io/darthsim/imgproxy:v3.8.0"
    "docker.io/supabase/postgres-meta:v0.95.1"
    "docker.io/supabase/edge-runtime:v1.69.28"
    "docker.io/supabase/logflare:1.27.0"
    "docker.io/supabase/postgres:15.8.1.085"
    "docker.io/timberio/vector:0.28.1-alpine"
    "docker.io/supabase/supavisor:2.7.4"
)

FAILED=()

for img in "${IMAGES[@]}"; do
    echo "Pulling: $img"
    if podman pull "$img"; then
        echo "  ✓ Success"
    else
        echo "  ✗ Failed"
        FAILED+=("$img")
    fi
    echo ""
done

echo "=== Summary ==="
echo "Total images: ${#IMAGES[@]}"
echo "Failed: ${#FAILED[@]}"

if [ ${#FAILED[@]} -gt 0 ]; then
    echo ""
    echo "Failed images:"
    for img in "${FAILED[@]}"; do
        echo "  - $img"
    done
    exit 1
fi

echo ""
echo "All images pulled successfully!"

