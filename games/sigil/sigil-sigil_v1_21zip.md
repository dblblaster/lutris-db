### url

https://lutris.net/api/installers/sigil-sigil_v1_21zip

### game_slug

sigil

### runner

linux

### version

SIGIL_v1_21.zip

### description

Requires The Ultimate Doom. Uses its launcher script that uses system's crispy-doom binary and stores persistent config in game directory.

### notes

```
Requires https://lutris.net/api/installers/the-ultimate-doom-v19ud-doomwad
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
- sigilzip: https://romero.com/s/SIGIL_v1_21.zip
game:
  args: -file wads/SIGIL_v1_21.wad
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
- extract:
    dst: $CACHE/sigilzip/
    file: sigilzip
- execute:
    args: $CACHE/sigilzip/SIGIL_v1_21/SIGIL_v1_21.wad $sigilwad121_sha256
    file: $CACHE/checkhash.sh
- execute:
    args: -n $CACHE/sigilzip/SIGIL_v1_21/SIGIL_v1_21.wad $GAMEDIR/wads/
    file: cp
require-binaries: sha256sum, crispy-doom
requires: the-ultimate-doom
variables:
  sigilwad121_sha256: 8aabb1fb729f8a9a4ed9316d8f42dd57ebe2dfdc70fc1416e66a6cd43eb61de9

```

