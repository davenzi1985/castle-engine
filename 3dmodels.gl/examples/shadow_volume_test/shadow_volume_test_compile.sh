#!/bin/bash
set -eu

# Call this from ../../../ (or just use `make examples').

fpc -dRELEASE @kambi.cfg \
  3dmodels.gl/examples/shadow_volume_test/shadow_volume_test.dpr