#!/bin/bash
#
# Run all scripts to download and process Pokemon position
# indicator graphics.
#

./scripts/download_sprites.sh
./scripts/generate_element_graphics.sh
./scripts/generate_pokemon_graphics.sh
./scripts/convert_to_xpm.sh
