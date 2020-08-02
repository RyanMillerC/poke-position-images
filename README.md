# Poke-Position Images

> Create images used by poke-mode

This repository contains a series of scripts used to generate images required
by [poke-mode](https://github.com/RyanMillerC/poke-mode). It relies on images
provided by [PokemonDB.net](https://pokemondb.net) and
[ImageMagick](https://imagemagick.org) to process images.

## Prerequisites

* [ImageMagick](https://imagemagick.org)
* [jq](https://stedolan.github.io/jq/)

*This has only been tested on MacOS, but I run GNU utils instead of the utils
bundled with MacOS so this **should** work on any Linux computer.*

## Usage

To generate images for poke-mode, execute:

```
./run.sh
```

## Process Breakdown

Poke-mode uses a Pokemon graphic to show position inside a file. This graphic
is made of two parts: the *Pokemon Image* and a repeated *Element Image*,
which changes based on the Pokemon's type.

### Pokemon Image

The Pokemon image is a generated 30x20 pixel image that has a Pokemon sprite,
obtained from PokemonDB.net, overlaid onto a *Base Image*.

A Base Image is meant to give the effect of a Pokemon using a move of their
type. Without this overlay, there would be a gap between the Pokemon sprite and
the first element type image.

All Pokemon sprites face left and must be flipped horizontally so that they
face the direction of the element type image.

Each sprite varies in size relative to the Pokemon's actual size. Since there
is only a 20 pixel height to work with, all whitespace around the sprite is
removed.

### Element Image

The Element Image is a 8x20 derrived from the above mentioned 30x20 Base
Image. The last 8x20 pixels of the Base Image are reserved for the Element
Image. This is the repeated image that shows the given position in a file.

The base images under *~/assets/base* are the only manually created images in
this project. Everything else is generated.

The assets created with these scripts are bundled with poke-mode.
These scripts only need to be run when new Pokemon are released.

### High-Level Process

1. Download sprites from PokemonDB.net into subdirectories based on type
2. Mirror, trim, and resize sprites
3. Overlay modified Pokemon sprites onto Base Images
4. Create Element images from Base Images
