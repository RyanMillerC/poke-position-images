#!/bin/bash
#
# Convert graphics to XPM format for Emacs poke-mode.
#

ELEMENTS_DIRECTORY='./assets/elements'
OUTPUT_DIRECTORY='./assets/output'
XPM_DIRECTORY='./assets/xpm'

[[ ! -d "${XPM_DIRECTORY}" ]] && mkdir "${XPM_DIRECTORY}"
[[ ! -d "${XPM_DIRECTORY}/elements" ]] && mkdir "${XPM_DIRECTORY}/elements"
[[ ! -d "${XPM_DIRECTORY}/pokemon" ]] && mkdir "${XPM_DIRECTORY}/pokemon"

for image in $(find "${ELEMENTS_DIRECTORY}" -name '*.png') ; do
    image_base_name="${image##*/}"
    xpm_base_name="${image_base_name/.png/.xpm}"
    output_file="${XPM_DIRECTORY}/elements/${xpm_base_name}"
    echo "Processing ${image} -> ${output_file}"
    convert "${image}" "${output_file}"
done

for image in $(find "${OUTPUT_DIRECTORY}" -name '*.png') ; do
    image_base_name="${image##*/}"
    xpm_base_name="${image_base_name/.png/.xpm}"
    output_file="${XPM_DIRECTORY}/pokemon/${xpm_base_name}"
    echo "Processing ${image} -> ${output_file}"
    convert "${image}" "${output_file}"
done

echo "Complete!"
