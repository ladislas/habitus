#!/usr/bin/env bash
#MISE description="Fix Swift lint issues"
set -euo pipefail

swiftlint --fix --quiet
