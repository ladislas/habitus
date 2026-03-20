#!/usr/bin/env bash
#MISE description="Generate and open Xcode workspace via Tuist"
#MISE depends=["tuist:install"]
set -euo pipefail

tuist generate
