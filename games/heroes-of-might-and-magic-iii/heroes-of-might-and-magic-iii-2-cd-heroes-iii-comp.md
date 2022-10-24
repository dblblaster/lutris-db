### url

https://lutris.net/api/installers/heroes-of-might-and-magic-iii-2-cd-heroes-iii-comp

### game_slug

heroes-of-might-and-magic-iii

### runner

wine

### version

2 CD Heroes III: Complete

### description



### notes

```
The installer is for Heroes III: Complete, 2 CD Version (includes Heroes III: The Restoration of Erathia, Heroes III: Armageddon's Blade, and Heroes III: Shadow of Death).
The 2 CDs are part of Heroes of Might and Magic: Platinum Edition

1. Rip both CDs (CDs 3 and 4 from Heroes of Might and Magic: Platinum Edition)
2. Mount both CDs
3. Proceed with installation. Do not install DirectX when asked.

On game first run, it will skip the intro and say it can not find the CD. That's ok, just exit the game and start it again.

Note: The downloaded nocd patch (1KB) is applied using bspatch. The patch will modify the installed HEROES3.EXE to match the GoG nocd version (resulting HEROES3.EXE sha256: b067f3c24467e8cd77f875f3cae4ebc9610d7989514261cbac0785f5c08ca751).
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
- nocdpatch_b64: https://www.klgrth.io/paste/5fpfj/raw
- cncddraw: https://github.com/FunkyFr3sh/cnc-ddraw/releases/download/v4.6.0.0/cnc-ddraw.zip
game:
  arch: win64
  exe: $GAMEDIR/$gamepath/HEROES3.EXE
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
    command: echo "[INFO] Preparing binary patch (1KB) for HEROES3.EXE..."; base64
      -d <(cat "$nocdpatch_b64") > "$CACHE/nocdpatch_b64/nocdpatch.bin";
- execute:
    args: $CACHE/nocdpatch_b64/nocdpatch.bin $nocdpatch_sha256
    file: $CACHE/checkhash.sh
- execute:
    args: cncddraw $cncddraw_sha256
    file: $CACHE/checkhash.sh
- insert-disc:
    requires: ../Heroes3/_setup/Setup.exe
- insert-disc:
    requires: ../H3_disk2/_autorun/heroes.ico
- task:
    arch: win64
    install_gecko: false
    install_mono: false
    name: create_prefix
    prefix: $GAMEDIR
- task:
    arch: win64
    executable: $DISC/../Heroes3/_setup/Setup.exe
    name: wineexec
    prefix: $GAMEDIR
- extract:
    dst: $GAMEDIR/$gamepath
    src: cncddraw
- execute:
    command: echo "[INFO] Applying the patch to generate gog nocd HEROES3.EXE (v4.0)...";
      bspatch "$GAMEDIR/$gamepath/HEROES3.EXE" "$CACHE/HEROES3.EXE" "$CACHE/nocdpatch_b64/nocdpatch.bin";
- execute:
    args: $CACHE/HEROES3.EXE $HEROES3_gog_sha256
    file: $CACHE/checkhash.sh
- execute:
    command: echo "[INFO] Overwriting installed HEROES3.EXE with gog nocd HEROES3.EXE..."
      mv "$GAMEDIR/$gamepath/HEROES3.EXE" "$CACHE/HEROES3.bak"; mv "$CACHE/HEROES3.EXE"
      "$GAMEDIR/$gamepath/HEROES3.EXE";
require-binaries: sha256sum, bspatch
variables:
  HEROES3_gog_sha256: b067f3c24467e8cd77f875f3cae4ebc9610d7989514261cbac0785f5c08ca751
  cncddraw_sha256: 1633d30bc80ecae60db97e881a4c804911e300dcb280d58ea8b8ddda2e1dd1ac
  gamepath: drive_c/Program Files (x86)/3DO/Heroes 3 Complete
  nocdpatch_sha256: c02f78c959e74972b4b32017c65f30798c06629a13e601ec4511db313cd738e1
wine:
  overrides:
    ddraw.dll: n

```

