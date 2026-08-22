#!/usr/bin/env bash
# Recreates the WinApps container against the current USB topology.
# Triggered by udev on Dymo LabelWriter add/replug (see 99-winapps-dymo.rules).
# Skips the recreate if the container is already running, so a printer
# replug never kills an active RDP session mid-use.
set -euo pipefail

readonly COMPOSE_PATH="${HOME}/.config/winapps/compose.yaml"
readonly LOG_DIR="${HOME}/.local/share/winapps"
readonly LOG_PATH="${LOG_DIR}/usb-recreate.log"
readonly LOCK_PATH="/tmp/winapps-usb-recreate.lock"

mkdir -p "$LOG_DIR"
exec 9>"$LOCK_PATH"
flock -n 9 || { echo "$(date -Is) skip: recreate already in progress" >>"$LOG_PATH"; exit 0; }

log() { echo "$(date -Is) $*" >>"$LOG_PATH"; }

STATE=$(podman inspect --format '{{.State.Status}}' WinApps 2>/dev/null || echo "missing")

if [ "$STATE" = "running" ]; then
    log "skip: container is running, not touching an active session"
    exit 0
fi

log "USB event: container state='${STATE}', recreating"
cd "$(dirname "$COMPOSE_PATH")"
if podman-compose --file "$COMPOSE_PATH" down >>"$LOG_PATH" 2>&1 \
    && podman-compose --file "$COMPOSE_PATH" up -d >>"$LOG_PATH" 2>&1; then
    log "recreate succeeded"
else
    log "recreate FAILED"
fi
