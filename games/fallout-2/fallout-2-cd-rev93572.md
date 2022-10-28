### url

https://lutris.net/api/installers/games/fallout-2/revisions/93572

### game_slug

fallout-2

### runner

wine

### version

CD

### description

Installs the game from CD and applies the last official patch (v1.02d)

### notes

```
The 1.02d patch can be downloaded here: https://www.patches-scrolls.com/dl.php?file=f2v102d.zip or here: http://www.nma-fallout.com/resources/official-and-unofficial-fallout-2-patches.57/download?version=73
```

### credits

```
null
```

### reason

```
fix the renaming script, add support for both patch archives
```

### content

```
files:
- patch102d: 'N/A: Please manually download "f2v102d.zip" (sha256: a728aebdd7d9731bbf30725efb727a6fbb1080c07f92270cb47143c6f047c161)
    or "English US official patch 1.02d.rar" (sha256: 6e2198b4a118d496dc9bbd65fa82233d254476fff1778fc36603cac817f7811e)'
- cncddraw: https://github.com/FunkyFr3sh/cnc-ddraw/releases/download/v4.6.0.0/cnc-ddraw.zip
game:
  arch: win32
  exe: $GAMEDIR/$gamepath/fallout2.exe
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
    dst: $CACHE/patch102d
    src: patch102d
- execute:
    command: cd "$CACHE/patch102d"; for i in *; do mv -n "$i" "$(echo $i | tr 'A-Z'
      'a-z')"; done
- execute:
    command: rm "$CACHE/patch102d"/*{3,4}.txt; mv "$CACHE/patch102d"/*.txt "$CACHE/patch102d/patch.txt"
- execute:
    args: $CACHE/patch102d/fallout2.exe $fallout2exe_sha256
    file: $CACHE/checkhash.sh
- execute:
    args: $CACHE/patch102d/patch000.dat $patch000dat_sha256
    file: $CACHE/checkhash.sh
- execute:
    args: $CACHE/patch102d/patch.txt $patchtxt_sha256
    file: $CACHE/checkhash.sh
- insert-disc:
    requires: ../FALLOUT2/setup.exe
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
    command: cp -rn "$DISC/../FALLOUT2/manual/manual.pdf" "$GAMEDIR/$gamepath/manual/"
- execute:
    command: cp -rn "$DISC/../FALLOUT2"/{data,critter.dat,master.dat,readme.txt} "$GAMEDIR/$gamepath/"
- execute:
    command: cp -rn "$CACHE/patch102d"/* "$GAMEDIR/$gamepath/"
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
    file: $GAMEDIR/$gamepath/fallout2.cfg
- execute:
    args: -R +rw $GAMEDIR/$gamepath
    file: chmod
require-binaries: sha256sum
variables:
  cncddraw_sha256: 1633d30bc80ecae60db97e881a4c804911e300dcb280d58ea8b8ddda2e1dd1ac
  fallout2exe_sha256: 581c09c20fee70edc09ec412ee034e62e89cdefa13092e534ddd17d23f8163cb
  gamepath: drive_c/Program Files/BlackIsle/Fallout2
  patch000dat_sha256: 16122a47d9fa1fb2f490d1fb38bb1b7eb8ca8edcf2c06a2c9d78beed812ff564
  patchtxt_sha256: 1983c69b95914e5a9fd2ffb3b42dd24a1a60a0d4abebc7baa9379926ea1428cc
wine:
  overrides:
    ddraw.dll: n

```

