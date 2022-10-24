### url

https://lutris.net/api/installers/half-life-cd-v100x

### game_slug

half-life

### runner

wine

### version

CD v1.0.0.x

### description

This is a base for other installers. Installs the CD version of the game and rips audio tracks to .mp3 files into game folder.

### notes

```
Do not run the game yet and do not patch manually.

When installation completes, proceed to use one of the 2 other installers:
- Half-Life - Patch v1.1.1.0 version - lutris:half-life-patch-v1110 (https://lutris.net/api/installers/half-life-patch-v1110).
- Half-Life: Opposing Force - CD v1.0.0.x version - lutris:half-life-opposing-force-cd-v100x (https://lutris.net/api/installers/half-life-opposing-force-cd-v100x).
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
game:
  arch: win32
  args: -full -gl -gldrv Default -width 1920 -height 1080 -console
  exe: $GAMEDIR/$gamepath/hl.exe
  prefix: $GAMEDIR
installer:
- insert-disc:
    requires: ../HALF_LIFE/Setup.exe
- write_file:
    content: '#!/bin/bash

      cddevice=$(mount | grep -m 1 HALF_LIFE | grep -oE "/dev/\w+"); mkdir -p "$GAMEDIR/$gamepath/valve/media";
      tracknames=("data" "Half-Life01.mp3" "Prospero01.mp3" "Half-Life12.mp3" "Half-Life07.mp3"
      "Half-Life10.mp3" "Suspense01.mp3" "Suspense03.mp3" "Half-Life09.mp3" "Half-Life02.mp3"
      "Half-Life13.mp3" "Half-Life04.mp3" "Half-Life15.mp3" "Half-Life14.mp3" "Half-Life16.mp3"
      "Suspense02.mp3" "Half-Life03.mp3" "Half-Life08.mp3" "Prospero02.mp3" "Half-Life05.mp3"
      "Prospero04.mp3" "Half-Life11.mp3" "Half-Life06.mp3" "Prospero03.mp3" "Half-Life17.mp3"
      "Prospero05.mp3" "Suspense05.mp3" "Suspense07.mp3"); for i in {2..28}; do cdda2wav
      -D "$cddevice" -t $i+$i - | lame -b 320 --id3v1-only - "$GAMEDIR/$gamepath/valve/media/${tracknames[$((i-1))]}";
      done

      '
    file: $CACHE/ripaudio.sh
- task:
    arch: win32
    install_gecko: false
    install_mono: false
    name: create_prefix
    prefix: $GAMEDIR
- task:
    arch: win32
    executable: $DISC/../HALF_LIFE/Setup.exe
    name: wineexec
    prefix: $GAMEDIR
- execute:
    args: $CACHE/ripaudio.sh
    file: bash
- move:
    dst: $GAMEDIR/$gamepath/gldrv/drvmap.txt.disabled
    src: $GAMEDIR/$gamepath/gldrv/drvmap.txt
- write_file:
    content: GL_texturemode GL_Nearest
    file: $GAMEDIR/$gamepath/valve/autoexec.cfg
require-binaries: cdda2wav, lame
variables:
  gamepath: drive_c/SIERRA/Half-Life
wine:
  Desktop: true
  dgvoodoo2: true

```

