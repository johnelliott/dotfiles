#!/usr/bin/env bash
set -euo pipefail

BUNDLE_ID="eu.exelban.Stats"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLIST="$SCRIPT_DIR/Stats.plist"

usage() {
  echo "Usage: $(basename "$0") <export|import>"
  exit 1
}

[[ $# -eq 1 ]] || usage

case "$1" in
  export)
    defaults export "$BUNDLE_ID" "$PLIST"
    echo "Exported Stats settings to $PLIST"
    ;;
  import)
    [[ -f "$PLIST" ]] || { echo "Error: $PLIST not found"; exit 1; }
    defaults import "$BUNDLE_ID" "$PLIST"
    echo "Imported Stats settings from $PLIST"
    echo "Restart Stats.app for changes to take effect."
    ;;
  *)
    usage
    ;;
esac
