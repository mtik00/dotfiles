#!/bin/bash
set -euo pipefail

# WinApps (https://github.com/winapps-org/winapps) on rootless podman, with
# USB passthrough for a Dymo LabelWriter 450 Turbo (vendorid=0x0922,
# productid=0x0021). Compose file is chezmoi-managed at
# ~/.config/winapps/compose.yaml (see dot_config/winapps/private_compose.yaml.tmpl).

readonly WINAPPS_SRC="${HOME}/.local/bin/winapps-src"
readonly WINAPPS_REMOTE="https://github.com/winapps-org/winapps.git"
readonly PATCH_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/patches/winapps-exited-fallback-recreate.patch"
readonly PATCH_MARKER="WINDOWS FAILED TO START. RECREATING WINDOWS CONTAINER."

# 1. Clone winapps upstream if not already present.
if [[ ! -d "${WINAPPS_SRC}/.git" ]]; then
    git clone "${WINAPPS_REMOTE}" "${WINAPPS_SRC}"
else
    echo "winapps-src already cloned"
fi

# 2. Symlink the CLI into place (this is what ~/.local/share/applications/windows.desktop calls).
mkdir -p "${HOME}/.local/bin"
ln -sf "${WINAPPS_SRC}/bin/winapps" "${HOME}/.local/bin/winapps"

# 3. Apply the local fallback-recreate patch if it isn't already present.
# NOTE: this is NOT upstreamed. If it stops applying cleanly after a
# `git pull` in winapps-src, reapply the fix by hand (see PATCH_FILE) --
# it makes the "exited" container-state case fall back to a full
# `podman-compose down && up -d` recreate when `start` fails (e.g. because
# a passed-through USB device's /dev/bus/usb node went stale).
if ! grep -q "${PATCH_MARKER}" "${WINAPPS_SRC}/bin/winapps"; then
    echo "Applying winapps exited-fallback-recreate patch..."
    if ! (cd "${WINAPPS_SRC}" && git apply --check "${PATCH_FILE}" 2>/dev/null); then
        echo "WARNING: patch no longer applies cleanly (upstream bin/winapps likely changed)." >&2
        echo "         Reapply the fix by hand -- see ${PATCH_FILE}" >&2
    else
        (cd "${WINAPPS_SRC}" && git apply "${PATCH_FILE}")
    fi
else
    echo "winapps exited-fallback-recreate patch already applied"
fi

# 4. Install the udev rule + systemd unit that recreates the WinApps
# container when the Dymo is (re)plugged, so a devnum change never leaves a
# stopped container pointing at a stale /dev/bus/usb path. Skips the
# recreate if the container is already running (see
# ~/.local/bin/winapps-usb-recreate.sh, chezmoi-managed).
if [[ ! -f /etc/systemd/system/winapps-usb-recreate.service ]]; then
    sudo tee /etc/systemd/system/winapps-usb-recreate.service >/dev/null <<EOF
[Unit]
Description=Recreate WinApps container after Dymo USB topology change

[Service]
Type=oneshot
User=${USER}
ExecStart=${HOME}/.local/bin/winapps-usb-recreate.sh
EOF
    sudo systemctl daemon-reload
else
    echo "winapps-usb-recreate.service already installed"
fi

if [[ ! -f /etc/udev/rules.d/99-winapps-dymo.rules ]]; then
    sudo tee /etc/udev/rules.d/99-winapps-dymo.rules >/dev/null <<'EOF'
# Recreate the WinApps container when the Dymo LabelWriter is (re)plugged,
# so a devnum change never leaves the container's stale /dev/bus/usb path
# baked into a stopped container. See ~/.local/bin/winapps-usb-recreate.sh.
ACTION=="add", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTR{idVendor}=="0922", ATTR{idProduct}=="0021", TAG+="systemd", ENV{SYSTEMD_WANTS}+="winapps-usb-recreate.service"
EOF
    sudo udevadm control --reload-rules
else
    echo "99-winapps-dymo.rules already installed"
fi
