### url

https://lutris.net/api/installers/games/doom-ii-no-rest-for-the-living/revisions/93169

### game_slug

doom-ii-no-rest-for-the-living

### runner

linux

### version

nerve.wad

### description

Requires Doom II: Hell on Earth. Uses its launcher script that uses system's crispy-doom binary and stores persistent config in game directory.

### notes

```
Requires https://lutris.net/api/installers/doom-ii-hell-on-earth-v19-doom2wad

NERVE.WAD is the PWAD containing No Rest for the Living and bundled with Doom and Doom II in Doom 3: BFG Edition. This file was used first in Doom II on XBLA, but is named Nerve_demo.wad in that version. The XBLA, Xbox 360 BFG Edition and PlayStation Network versions are identical to the version bundled in Doom 3: BFG Edition.

It is 3,819,855 bytes in size, contains 108 entries, and has the following hashes:
Hash type 	Hash code
MD5 	967d5ae23daf45196212ae1b605da3b0
SHA-1 	3451288383fb16e196f273d9f85d58c1fda97bf4
CRC-32 	ad7f9292
```

### credits

```
null
```

### reason

```
fix link
```

### content

```
files:
- nervewad: 'N/A: Please provide nerve.wad (sha256: 2d234de8700ee403375fda278e50ea17739b36703b3316e0429b05aca4458fa9)'
game:
  args: -episode 2
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
    dst: $CACHE/nervewad
    src: nervewad
- execute:
    args: nervewad $nervewad_sha256
    file: $CACHE/checkhash.sh
- execute:
    args: -n nervewad $GAMEDIR/wads/NERVE.WAD
    file: cp
require-binaries: sha256sum, crispy-doom
requires: doom-ii-hell-on-earth
variables:
  nervewad_sha256: 2d234de8700ee403375fda278e50ea17739b36703b3316e0429b05aca4458fa9

```

