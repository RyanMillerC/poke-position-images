#!/bin/bash
#
# Run all scripts to download and process Pokemon position
# indicator graphics.
#

echo "Downloading sprites..."
./scripts/download_sprites.sh

echo "Generating pokemon type graphics..."
./scripts/generate_element_graphics.sh

echo "Generating pokemon graphics..."
./scripts/generate_pokemon_graphics.sh
