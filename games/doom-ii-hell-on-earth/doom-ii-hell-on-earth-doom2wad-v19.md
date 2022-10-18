### url

https://lutris.net/api/installers/games/doom-ii-hell-on-earth/revisions/93101

### game_slug

doom-ii-hell-on-earth

### runner

linux

### version

doom2.wad (v1.9)

### description

Made to run using system's crispy-doom binary

### notes

```
Requires crispy-doom (https://github.com/fabiangreffrath/crispy-doom) package for your Linux distribution to be installed.

Version 1.9 is 14,604,584 bytes in size, is dated 1995-02-01, and contains 2,919 entries. It has the following hashes:
Hash type 	Hash code
MD5 	25e1459ca71d321525f84628f45ca8cd
SHA-1 	7ec7652fcfce8ddc6e801839291f0e28ef1d5ae7
CRC-32 	ec8725db 
Source: https://doomwiki.org/wiki/DOOM2.WAD
```

### content

```
files:
- doom2wad19: 'N/A: Please provide doom2.wad v1.9 (sha256: 10d67824b11025ddd9198e8cfc87ca335ee6e2d3e63af4180fa9b8a471893255)'
game:
  exe: $GAMEDIR/doom2.sh
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
    dst: $CACHE/doom2wad19
    src: doom2wad19
- execute:
    args: '"doom2wad19" $doom2wad19_sha256'
    file: $CACHE/checkhash.sh
- execute:
    command: mkdir -p $GAMEDIR/wads
- merge:
    dst: $GAMEDIR/wads
    src: $CACHE/doom2wad19
- execute:
    command: mkdir -p $GAMEDIR/savegames/doom2.wad
- write_file:
    content: '#!/bin/bash

      crispy-doom -config default.cfg -extraconfig crispy-doom.cfg -iwad wads/doom2.wad
      -savedir savegames/doom2.wad $@

      '
    file: $GAMEDIR/doom2.sh
- execute:
    args: +x $GAMEDIR/doom2.sh
    file: chmod
variables:
  doom2wad19_sha256: 10d67824b11025ddd9198e8cfc87ca335ee6e2d3e63af4180fa9b8a471893255

```
