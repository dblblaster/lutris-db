### url

https://lutris.net/api/installers/games/the-ultimate-doom/revisions/93529

### game_slug

the-ultimate-doom

### runner

linux

### version

v1.9ud doom.wad

### description

Creates launcher script that uses system's crispy-doom binary and stores persistent config in game directory.

### notes

```
Requires crispy-doom (https://github.com/fabiangreffrath/crispy-doom) package for your Linux distribution to be installed.

Version 1.9ud of the Ultimate Doom WAD is 12,408,292 bytes in size, is dated 1995-05-25, and contains 2,306 entries. It has the following hashes:
Hash type 	Hash code
MD5 	c4fe9fd920207691a9f493668e0a2083
SHA-1 	9b07b02ab3c275a6a7570c3f73cc20d63a0e3833
CRC-32 	bf0eaac0 
Source: https://doomwiki.org/wiki/DOOM.WAD
```

### credits

```
null
```

### reason

```
Ensure filename will be correct
```

### content

```
files:
- doomwad19ud: 'N/A: Please provide v1.9ud doom.wad (sha256: 6fdf361847b46228cfebd9f3af09cd844282ac75f3edbb61ca4cb27103ce2e7f)'
game:
  exe: $GAMEDIR/doom.sh
installer:
- write_file:
    content: '#!/bin/bash

      file="$1"; hash="$2"; echo "[INFO] Verifying $(basename "$file") sha256 checksum...";
      if [ $(sha256sum "$file" | cut -c 1-64) = "$hash" ]; then echo "[INFO] ...checksum
      OK!"; else echo "[ERROR] ...checksum FAILED!"; exit 1; fi

      '
    file: $CACHE/checkhash.sh
- execute:
    args: +x $CACHE/checkhash.sh
    file: chmod
- merge:
    dst: $CACHE/doomwad19ud
    src: doomwad19ud
- execute:
    args: doomwad19ud $doomwad19ud_sha256
    file: $CACHE/checkhash.sh
- execute:
    args: -p $GAMEDIR/wads
    file: mkdir
- execute:
    args: -n doomwad19ud $GAMEDIR/wads/DOOM.WAD
    file: cp
- execute:
    args: -p $GAMEDIR/savegames/doom.wad
    file: mkdir
- write_file:
    content: '#!/bin/bash

      crispy-doom -config default.cfg -extraconfig crispy-doom.cfg -iwad wads/doom.wad
      -savedir savegames/doom.wad $@

      '
    file: $GAMEDIR/doom.sh
- execute:
    args: +x $GAMEDIR/doom.sh
    file: chmod
require-binaries: sha256sum, crispy-doom
variables:
  doomwad19ud_sha256: 6fdf361847b46228cfebd9f3af09cd844282ac75f3edbb61ca4cb27103ce2e7f

```

