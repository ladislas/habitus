#!/usr/bin/env bash
#MISE description="Generate Xcode workspace via Tuist without opening Xcode"
#MISE depends=["tuist:install"]
set -euo pipefail

tuist generate --no-open
