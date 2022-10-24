### url

https://lutris.net/api/installers/starcraft-brood-war-battle-chest-2-cd

### game_slug

starcraft-brood-war

### runner

wine

### version

Battle Chest 2 CD

### description

Installs both StarCraft and StartCraft: Brood War. Patches to 1.16.1.

### notes

```
This edition requires a 26-character CD-key.

1. Rip both CDs
2. Mount both CDs
3. Proceed with installation
4. When patch 1.16.1 completes installation it will automatically start the game. Exit the game to complete the installation.
```

### credits

```
Runs smooth thanks to https://github.com/FunkyFr3sh/cnc-ddraw
```

### reason

```
null
```

### content

```
files:
- patch1161: https://web.archive.org/web/20140908015808/http://ftp.blizzard.com/pub/starcraft/patches/PC/SC-1161.exe
- cncddraw: https://github.com/FunkyFr3sh/cnc-ddraw/releases/download/v4.6.0.0/cnc-ddraw.zip
game:
  arch: win64
  exe: $GAMEDIR/$gamepath/StarCraft.exe
  prefix: $GAMEDIR
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
- execute:
    args: patch1161 $patch1161_sha256
    file: $CACHE/checkhash.sh
- execute:
    args: cncddraw $cncddraw_sha256
    file: $CACHE/checkhash.sh
- insert-disc:
    requires: ../SCDisc1/Installer Tome.mpq
- insert-disc:
    requires: ../SCDisc2/Installer Tome 2.mpq
- task:
    arch: win64
    install_gecko: false
    install_mono: false
    name: create_prefix
    prefix: $GAMEDIR
- task:
    arch: win64
    executable: $DISC/../SCDisc1/StarCraft (Windows).exe
    name: wineexec
    prefix: $GAMEDIR
- task:
    arch: win64
    executable: patch1161
    name: wineexec
    prefix: $GAMEDIR
- extract:
    dst: $GAMEDIR/$gamepath
    src: cncddraw
require-binaries: sha256sum
variables:
  cncddraw_sha256: 1633d30bc80ecae60db97e881a4c804911e300dcb280d58ea8b8ddda2e1dd1ac
  gamepath: drive_c/Program Files (x86)/StarCraft
  patch1161_sha256: 755b4dbe3f8a928831b19bfa975445885b8c1760ffa4e5a795d37e7f02e6c31e
wine:
  overrides:
    ddraw.dll: n

```

