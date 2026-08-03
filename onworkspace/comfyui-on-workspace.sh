#!/bin/bash

move_with_progress() {
    local source="$1"
    local destination="$2"
    local temporary_destination="${destination}.moving"
    local total_bytes
    local copied_bytes
    local previous_bytes=-1
    local unchanged_seconds=0
    local elapsed_seconds=0
    local status_interval="${MOVE_STATUS_INTERVAL:-5}"
    local stall_timeout="${MOVE_STALL_TIMEOUT:-300}"
    local copy_pid

    total_bytes="$(du -sb "$source" | awk '{print $1}')"
    rm -rf "$temporary_destination"
    mkdir -p "$temporary_destination"

    echo "ℹ️ Moving $source to $destination"
    echo "ℹ️ Around 3.0 Gb"
    echo "ℹ️ Status interval: ${status_interval}s; stall timeout: ${stall_timeout}s"

    cp -a "$source"/. "$temporary_destination"/ &
    copy_pid=$!

    while kill -0 "$copy_pid" 2>/dev/null; do
        copied_bytes="$(du -sb "$temporary_destination" 2>/dev/null | awk '{print $1}')"
        copied_bytes="${copied_bytes:-0}"
        elapsed_seconds=$(( elapsed_seconds + status_interval ))

        if (( copied_bytes != previous_bytes )); then
            previous_bytes="$copied_bytes"
            unchanged_seconds=0
            echo "Moving ComfyUI: active after ${elapsed_seconds}s; copied approximately $(numfmt --to=iec-i --suffix=B "$copied_bytes")"
        else
            unchanged_seconds=$(( unchanged_seconds + status_interval ))
            echo "Moving ComfyUI: waiting after ${elapsed_seconds}s; no size change for ${unchanged_seconds}s"
        fi

        if (( unchanged_seconds >= stall_timeout )); then
            echo "❌ Move stalled: no size change for ${stall_timeout}s. Stopping copy."
            kill "$copy_pid" 2>/dev/null || true
            wait "$copy_pid" 2>/dev/null || true
            rm -rf "$temporary_destination"
            return 1
        fi

        sleep "$status_interval"
    done

    if ! wait "$copy_pid"; then
        echo "❌ Failed to copy $source to $destination; source was preserved."
        rm -rf "$temporary_destination"
        return 1
    fi

    mv "$temporary_destination" "$destination"
    rm -rf "$source"
    echo "✅ Move completed"
}

# Ensure we have /workspace in all scenarios
mkdir -p /workspace

if [[ ! -d /workspace/ComfyUI ]]; then
    move_with_progress /ComfyUI /workspace/ComfyUI || exit 1
    # Set permissions right for directory
    chmod -R 777 /workspace/ComfyUI/user
else
    rm -rf /ComfyUI
fi

# Linking
ln -s /workspace/ComfyUI /ComfyUI
