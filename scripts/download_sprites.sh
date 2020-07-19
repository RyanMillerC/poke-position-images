#!/bin/bash
#
# Download Pokemon sprites from PokemonDB.net into a local directory.
#

BASE_IMAGE_URL='https://img.pokemondb.net/sprites/sword-shield/icon'
SPRITES_DIRECTORY='./assets/sprites'

[[ ! -d "${SPRITES_DIRECTORY}" ]] && mkdir "${SPRITES_DIRECTORY}"

number_of_pokemon=$(jq '. | length' pokemon-data.json)
for ((iterator=0; iterator<number_of_pokemon; iterator++)) ; do
    pokemon_name=$(jq -r ".[${iterator}].name" pokemon-data.json)
    pokemon_type=$(jq -r ".[${iterator}].type" pokemon-data.json)

    # Some Pokemon have different sprite file names
    pokemon_sprite_name=$(jq -r ".[${iterator}].spriteName" pokemon-data.json)

    output_directory="${SPRITES_DIRECTORY}/${pokemon_type}"
    [[ ! -d "${output_directory}" ]] && mkdir "${output_directory}"
    output_file="${SPRITES_DIRECTORY}/${pokemon_type}/${pokemon_name}.png"

    [[ ${pokemon_sprite_name} == 'null' ]] && pokemon_sprite_name="${pokemon_name}"
    url_safe_pokemon_sprite_name=$(echo "${pokemon_sprite_name}" | tr ' ' '-')
    pokemon_image_url="${BASE_IMAGE_URL}/${url_safe_pokemon_sprite_name}.png"
    echo "Downloading ${pokemon_image_url} -> ${output_file}"
    curl -s "${pokemon_image_url}" -o "${output_file}"

    # Verify a PNG image was downloaded
    grep -q 'PNG' <<< $(file "${output_file}")
    [[ $? == 0 ]] || >&2 echo "WARNING: ${output_file} does not appear to be valid a PNG image"
done

echo "Complete!"
