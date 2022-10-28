### url

https://lutris.net/api/installers/diablo-hellfire-cd

### game_slug

diablo-hellfire

### runner

wine

### version

CD

### description

Installs the game from original CD. Applies the last official patch (v1.01). Patches a single byte in storm.dll to allow playing without the CD. Patches a single byte in hellfrui.dll to enable multiplayer.

### notes

```
When prompted by the original installer, be sure to check both "Music Files" and "Hi-res voice files".

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
- patch101: http://savagesteel.free.fr/diablo/files/Hellfire.Patch.1.01.7z
game:
  arch: win32
  exe: $GAMEDIR/$gamepath/hellfire.exe
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
    dst: $CACHE/patch101
    src: patch101
- execute:
    args: '"$CACHE/patch101/Hellfire Patch 1.01.exe" $patch101_sha256'
    file: $CACHE/checkhash.sh
- insert-disc:
    requires: ../HELLFIRE/hellfire.exe
- task:
    executable: $DISC/../HELLFIRE/SETUP.EXE
    name: wineexec
    prefix: $GAMEDIR
- task:
    executable: $CACHE/patch101/Hellfire Patch 1.01.exe
    name: wineexec
    prefix: $GAMEDIR
- execute:
    command: diabdat=$(find "$GAMEDIR" -type f -name diabdat.mpq | head -n 1); ln
      -rs "$diabdat" "$GAMEDIR/$gamepath/diabdat.mpq"
- execute:
    command: printf "\xeb" | dd of="$GAMEDIR/$gamepath/storm.dll" bs=1 count=1 seek=52177
      conv=notrunc
- execute:
    command: printf "\xeb" | dd of="$GAMEDIR/$gamepath/hellfrui.dll" bs=1 count=1
      seek=31122 conv=notrunc
- extract:
    dst: $GAMEDIR/$gamepath
    src: cncddraw
require-binaries: sha256sum
requires: diablo
variables:
  cncddraw_sha256: 1633d30bc80ecae60db97e881a4c804911e300dcb280d58ea8b8ddda2e1dd1ac
  gamepath: drive_c/SIERRA/HELLFIRE
  patch101_sha256: 4efe01b3d29e17733e1422467a9bd69b7af76b6f2284fc4bc7371fc9561a5184
wine:
  overrides:
    ddraw.dll: n

```

