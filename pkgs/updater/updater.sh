#!/usr/bin/env bash

set -e

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <nixos-config-path> <system|hm> <profilename|username>"
  exit 1
fi

CONFIG_PATH=$1
ACTION=$2
PROFILE=$3

if [ ! -d "$CONFIG_PATH" ]; then
  echo "Error: Directory '$CONFIG_PATH' does not exist."
  exit 1
fi

cd "$CONFIG_PATH"
git add .

case $ACTION in
  system)
    echo "Updating system with profile: $PROFILE from configuration at $CONFIG_PATH"
    sudo nixos-rebuild switch --flake .#"${PROFILE}"
    ;;
  hm)
    echo "Updating Home Manager for user: $PROFILE from configuration at $CONFIG_PATH"
    home-manager switch --flake .#"${PROFILE}"
    ;;
  *)
    echo "Invalid action: $ACTION. Use 'system' or 'hm'."
    exit 1
    ;;
esac

