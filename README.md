# Poke-Position Images

> Create images used by poke-mode and poke-position

This repository contains code to generate images required by
[poke-mode](https://github.com/RyanMillerC/poke-mode) and
[poke-position](https://github.com/RyanMillerC/poke-position).

It relies on images provided by [PokemonDB.net](https://pokemondb.net)
and information provided by [PokeAPI](https://pokeapi.co) to
generate images.

It uses [ImageMagick](https://imagemagick.org) to process images.

## Information

Poke-mode and Poke-Position use a Pokemon graphic to show position
inside a file. This graphic is made of two parts: the *Pokemon
Position Image* and a repeated *Element Image*, which changes based on
the Pokemon's type.

The Pokemon image is a generated 20x30 pixel image that has a Pokemon
sprite, obtained from PokemonDB.net, overlaid onto a *Base Image*.
The base image is a half-transparent, half-element image meant to give
the effect of a Pokemon using a move of their type. Without this
overlay, there would be a gap between the Pokemon sprite and the first
element image.

The element image is derrived from the same 20x30 base image. The last
8x20 pixels of the base-image are reserved for the element image. It
is a repeated image that shows the given position in a file in a style
matching the Pokemon's type.

The Base Images under *~/assets/base* are the only manually created
images in this project. Everything else is generated.

This process only needs to occur when a new version of either package
needs it's graphics updated. The assets created from this repo are
bundled with both packages.

## High-Level Process

1. Query PokeAPI for all Pokemon names and types
2. Download sprites from PokemonDB.net into subdirectories based on type
3. Mirror, trim, and resize sprites
4. Overlay modified Pokemon sprites onto Base Images
5. Create Element images from Base Images

## Notes

Pokemon data is from [pokemon.json](https://github.com/fanzeyi/pokemon.json).
Data from that repo was striped down to only relevant fields: id, name,
and type (primary). This is achieved with the command below.

```
jq -rM '.[] | {id: .id, name: .name.english|ascii_downcase, type: .type[0]|ascii_downcase }' pokedex.json > pokemon-data.json
```
