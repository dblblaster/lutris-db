### url

https://lutris.net/api/installers/fallout-cd

### game_slug

fallout

### runner

wine

### version

CD

### description

Installs the game from CD and applies the last official patch (v1.1)

### notes

```
The v1.1 patch can be downloaded here: https://www.nma-fallout.com/resources/fallout-official-v1-1-patch-windows.50/download?version=51
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
- patch11: 'N/A: Please manually download "fallup1w.zip" (sha256: d5cdc2fe920032e2efc4b55b800ee26628346591a002f26f85100c57b077312a)'
- cncddraw: https://github.com/FunkyFr3sh/cnc-ddraw/releases/download/v4.6.0.0/cnc-ddraw.zip
game:
  arch: win32
  exe: $GAMEDIR/$gamepath/falloutw.exe
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
- write_file:
    content: '#!/bin/bash

      dir="$(dirname "$1")"; fil="$(basename "$1")"; lcfil="$(echo "$fil" | tr ''A-Z''
      ''a-z'')"; mv -nT "$dir/$fil" "$dir/$lcfil"

      '
    file: $CACHE/lowercaps.sh
- execute:
    args: +x $CACHE/lowercaps.sh
    file: chmod
- execute:
    args: cncddraw $cncddraw_sha256
    file: $CACHE/checkhash.sh
- execute:
    args: patch11 $patch11_sha256
    file: $CACHE/checkhash.sh
- extract:
    dst: $CACHE/patch11
    src: patch11
- extract:
    dst: $CACHE/fall11
    src: $CACHE/patch11/FALL11.ZIP
- execute:
    command: find "$CACHE/fall11"/* -depth -exec "$CACHE/lowercaps.sh" {} \;
- insert-disc:
    requires: ../FALLOUT/setup.exe
- task:
    arch: win32
    install_gecko: false
    install_mono: false
    name: create_prefix
    prefix: $GAMEDIR
- execute:
    args: -p $GAMEDIR/$gamepath/manual
    file: mkdir
- execute:
    command: cp -rn "$DISC/../FALLOUT/manual/manual.pdf" "$GAMEDIR/$gamepath/manual/"
- execute:
    command: cp -rn "$DISC/../FALLOUT"/{data,critter.dat,master.dat,readme.txt} "$GAMEDIR/$gamepath/"
- execute:
    args: -R +rw $GAMEDIR/$gamepath
    file: chmod
- execute:
    command: cp -n "$CACHE/patch11/PATCH.TXT" "$GAMEDIR/$gamepath/patch.txt"
- execute:
    command: cp -rn "$CACHE/fall11"/* "$GAMEDIR/$gamepath/"
- extract:
    dst: $GAMEDIR/$gamepath
    src: cncddraw
- write_file:
    content: '[sound]

      music_path1=data\sound\music\

      music_path2=data\sound\music\


      [system]

      critter_dat=critter.dat

      critter_patches=data

      master_dat=master.dat

      master_patches=data

      '
    file: $GAMEDIR/$gamepath/fallout.cfg
- execute:
    args: -R +rw $GAMEDIR/$gamepath
    file: chmod
require-binaries: sha256sum
variables:
  cncddraw_sha256: 1633d30bc80ecae60db97e881a4c804911e300dcb280d58ea8b8ddda2e1dd1ac
  gamepath: drive_c/Program Files/Interplay/Fallout
  patch11_sha256: d5cdc2fe920032e2efc4b55b800ee26628346591a002f26f85100c57b077312a
wine:
  overrides:
    ddraw.dll: n

```

