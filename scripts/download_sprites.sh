#!/bin/bash
#
# Download Pokemon sprites.
#
# Download Pokemon sprites by first querying PokeAPI for Pokemon
# names and types, then downloading sprites by name from PokemonDB.net
# into a local directory.
#

BASE_IMAGE_URL='https://img.pokemondb.net/sprites/sword-shield/icon'
SPRITES_DIRECTORY='./assets/sprites'

[[ ! -d "${SPRITES_DIRECTORY}" ]] && mkdir "${SPRITES_DIRECTORY}"

for ((iterator=0; iterator<=25; iterator++)) ; do
    pokemon_name=$(jq -r ".[${iterator}].name" pokemon-data.json)
    pokemon_type=$(jq -r ".[${iterator}].type" pokemon-data.json)

    output_directory="${SPRITES_DIRECTORY}/${pokemon_type}"
    [[ ! -d "${output_directory}" ]] && mkdir "${output_directory}"
    output_file="${SPRITES_DIRECTORY}/${pokemon_type}/${pokemon_name}.png"

    pokemon_image_url="${BASE_IMAGE_URL}/${pokemon_name}.png"
    echo "Downloading ${pokemon_image_url} -> ${output_file}"
    curl -s "${pokemon_image_url}" -o "${output_file}"
done

echo "Complete!"
