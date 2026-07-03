#!/usr/bin/env bash
# fetch-pythons.sh — vendor PBS interpreters into the install bundle
set -euo pipefail

MINOR="${1:-3.12}"                 # python minor version to track
DEST="${2:-pythons}"               # bundle output dir
REPO="astral-sh/python-build-standalone"

PLATFORMS=(
  "x86_64-unknown-linux-gnu"
  "x86_64-pc-windows-msvc"
)

# 1. Resolve latest release tag via redirect (no API => no rate limits)
TAG=$(curl -fsSI "https://github.com/${REPO}/releases/latest" \
      | awk -F'/tag/' '/^location:/ {print $2}' | tr -d '\r')
echo "==> release tag: ${TAG}"

BASE="https://github.com/${REPO}/releases/download/${TAG}"
mkdir -p "${DEST}"

# 2. Pull SHA256SUMS — doubles as the asset index and the verification source
curl -fsSL -o "${DEST}/SHA256SUMS" "${BASE}/SHA256SUMS"

for PLAT in "${PLATFORMS[@]}"; do
  # 3. Discover exact patch version + filename from the sums index
  LINE=$(grep -E "cpython-${MINOR//./\\.}\.[0-9]+\+${TAG}-${PLAT}-install_only\.tar\.gz\$" \
         "${DEST}/SHA256SUMS" | sort -V | tail -1)
  [[ -n "${LINE}" ]] || { echo "!! no ${MINOR} asset for ${PLAT}"; exit 1; }

  SHA=$(awk '{print $1}' <<<"${LINE}")
  FILE=$(awk '{print $2}' <<<"${LINE}")
  echo "==> ${FILE}"

  # 4. Download (skip if cached+valid) and verify
  if [[ ! -f "${DEST}/${FILE}" ]] || ! sha256sum -c --status <<<"${SHA}  ${DEST}/${FILE}"; then
    curl -fL --retry 3 -o "${DEST}/${FILE}" "${BASE}/${FILE}"
    sha256sum -c --status <<<"${SHA}  ${DEST}/${FILE}" || { echo "!! checksum FAIL"; exit 1; }
  fi
done

echo "==> done — pinned manifest:"
grep -f <(ls "${DEST}" | grep cpython) "${DEST}/SHA256SUMS" | tee "${DEST}/MANIFEST.sha256"
