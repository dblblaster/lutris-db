### url

https://lutris.net/api/installers/diablo-cd

### game_slug

diablo

### runner

wine

### version

CD

### description

Installs the game from original CD. Applies last official patch (v1.09b). Patches a single byte in Storm.dll to allow playing without the CD.

### notes

```
1. In original setup launcher, click the "Install" button and install using default options
2. When it completes just click "Exit Installer" to continue
3. Patch will install next. When you click "OK" the patcher window will close but it will start the game. Exit the game (press ESC a few times) to complete lutris setup. It may leave some graphics artifacts on your screen, those will disappear later.
4. Normally launch the game from lutris

Note: Game menus are graphically broken, but you can get them to appear if you repeatedly press up or down keyboard arrows. The menu entry which doesn't show the pentagram sign is the one you have selected.
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
- cncddraw: https://github.com/FunkyFr3sh/cnc-ddraw/releases/download/v4.6.0.0/cnc-ddraw.zip
- patch109b: http://savagesteel.free.fr/diablo/files/Diablo.Patch.1.09b.7z
game:
  arch: win32
  exe: $GAMEDIR/$gamepath/Diablo.exe
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
    args: cncddraw $cncddraw_sha256
    file: $CACHE/checkhash.sh
- extract:
    dst: $CACHE/patch109b
    src: patch109b
- execute:
    args: '"$CACHE/patch109b/Diablo Patch 1.09b.exe" $patch109b_sha256'
    file: $CACHE/checkhash.sh
- insert-disc:
    requires: ../DIABLO/diabdat.mpq
- task:
    arch: win32
    install_gecko: false
    install_mono: false
    name: create_prefix
    prefix: $GAMEDIR
- task:
    app: corefonts
    name: winetricks
    silent: true
- task:
    executable: $DISC/../DIABLO/setup.exe
    name: wineexec
    prefix: $GAMEDIR
- task:
    executable: $CACHE/patch109b/Diablo Patch 1.09b.exe
    name: wineexec
    prefix: $GAMEDIR
- merge:
    dst: $GAMEDIR/$gamepath
    src: $DISC/../DIABLO/diabdat.mpq
- execute:
    command: printf "\xeb" | dd of="$GAMEDIR/$gamepath/Storm.dll" bs=1 count=1 seek=99962
      conv=notrunc
- extract:
    dst: $GAMEDIR/$gamepath
    src: cncddraw
require-binaries: sha256sum
variables:
  cncddraw_sha256: 1633d30bc80ecae60db97e881a4c804911e300dcb280d58ea8b8ddda2e1dd1ac
  gamepath: drive_c/Program Files/Diablo
  patch109b_sha256: d72eb4d54737694645c5798be6f6d38ff8b91e8f37a78b4c2ac622ecd2c5dd29
wine:
  overrides:
    ddraw.dll: n

```

