#!/bin/bash
set -e

nix flake update
sudo nixos-rebuild switch --flake .#thinkpad
home-manager switch --flake .#fulstaph

