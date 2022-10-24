### url

https://lutris.net/api/installers/final-doom-v19-2-tntwad-plutoni

### game_slug

final-doom

### runner

linux

### version

v1.9-2 tnt.wad & plutonia.wad

### description

Creates launcher script that uses system's crispy-doom binary and stores persistent config in game directory. Provides launcher options for both tnt.wad and plutonia.wad.

### notes

```
Requires crispy-doom (https://github.com/fabiangreffrath/crispy-doom) package for your Linux distribution to be installed.

Notes for tnt.wad

A slightly different, and rarer, version is found on some, but not all, id Anthology discs as well as the Macintosh version of Final Doom. This alternate version of the IWAD is also the one available for purchase from GOG.com. This version does not have the yellow keycard bug, and has a few changes in MAP10. Unfortunately, there is no revision change between both versions so it is also called v1.9. It is 18,654,796 bytes in size, contains 3,106 entries, it is dated 1996-11-14 and has the following hashes:
Hash type 	Hash code
MD5 	1d39e405bf6ee3df69a8d2646c8d5c49
SHA-1 	4a65c8b960225505187c36040b41a40b152f8f3e
CRC-32 	d4bb05c0 
Source: https://doomwiki.org/wiki/TNT.WAD

Notes for plutonia.wad

A slightly different, and rarer, version is found on some, but not all, id Anthology discs as well as the Macintosh version of Final Doom. This alternate version of the IWAD is also the one available for purchase from GOG.com. This version adds the missing deathmatch starts to MAP12 and MAP23. Unfortunately, there is no revision change between both versions so it is also called v1.9. It is 18,240,172 bytes in size, contains 2,988 entries, it is dated 1996-11-21 and has the following hashes:
Hash type 	Hash code
MD5 	3493be7e1e2588bc9c8b31eab2587a04
SHA-1 	f131cbe1946d7fddb3caec4aa258c83399c21e60
CRC-32 	15cd1448
Source: https://doomwiki.org/wiki/PLUTONIA.WAD
```

### credits

```

```

### reason

```
null
```

### content

```
files:
- tntwad192: 'N/A: Please provide v1.9-2 tnt.wad (sha256: be3130f780037d0a640fce5639f4e2df88ce2d36128725a675f9aec1b6048228)'
- plutoniawad192: 'N/A: Please provide v1.9-2 plutonia.wad (sha256: f31395fb5580ef8fee26514b34874f8ab354c78fbbed35c8bfe04ec42ddc0c80)'
game:
  args: tnt
  exe: $GAMEDIR/final-doom.sh
  launch_configs:
  - exe: tnt
    name: 'TNT: Evilution'
  - exe: plutonia
    name: The Plutonia Experiment
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
    dst: $CACHE/tntwad192
    src: tntwad192
- execute:
    args: tntwad192 $tntwad192_sha256
    file: $CACHE/checkhash.sh
- merge:
    dst: $CACHE/plutoniawad192
    src: plutoniawad192
- execute:
    args: plutoniawad192 $plutoniawad192_sha256
    file: $CACHE/checkhash.sh
- execute:
    args: -p $GAMEDIR/wads
    file: mkdir
- merge:
    dst: $GAMEDIR/wads
    src: $CACHE/tntwad192
- execute:
    args: -p $GAMEDIR/savegames/tnt.wad
    file: mkdir
- merge:
    dst: $GAMEDIR/wads
    src: $CACHE/plutoniawad192
- execute:
    args: -p $GAMEDIR/savegames/plutonia.wad
    file: mkdir
- write_file:
    content: '#!/bin/bash

      game=$1; set -- "${@:2}";

      crispy-doom -config default.cfg -extraconfig crispy-doom.cfg -iwad wads/$game.wad
      -savedir savegames/$game.wad $@

      '
    file: $GAMEDIR/final-doom.sh
- execute:
    args: +x $GAMEDIR/final-doom.sh
    file: chmod
require-binaries: sha256sum, crispy-doom
variables:
  plutoniawad192_sha256: f31395fb5580ef8fee26514b34874f8ab354c78fbbed35c8bfe04ec42ddc0c80
  tntwad192_sha256: be3130f780037d0a640fce5639f4e2df88ce2d36128725a675f9aec1b6048228

```

