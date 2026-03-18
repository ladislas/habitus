#!/usr/bin/env bash
#MISE description="Clean Tuist artifacts and derived data"
set -euo pipefail

tuist clean
rm -rf .build
rm -rf ~/Library/Developer/Xcode/DerivedData
find . -type d -name "*.xcodeproj" -exec rm -rf {} +
