### url

https://lutris.net/api/installers/half-life-blue-shift-cd-v1000

### game_slug

half-life-blue-shift

### runner

wine

### version

CD v1.0.0.0

### description

This installs and updates the game to the last World Opponent Network (WON) non-Steam version. Installs the CD version of the game and rips audio tracks to .mp3 files in game folder. Patches Blue Shift to v1.0.0.1. Applies official HD pack patch to all 3 games. Applies community "bshift_unlocked" patch to convert the game from standalone version to Half-Life mod.

### notes

```
Requires Half-Life v1.1.1.0 and optionally Half-Life: Opposing Force v1.1.0.9 to be installed, and assumes community resolution/FoV/mp3 patch v1.1.2 has been applied.
For best results use Half-Life: Opposing Force - CD v1.0.0.x version - lutris:half-life-opposing-force-cd-v100x (https://lutris.net/api/installers/half-life-opposing-force-cd-v100x).

Run the game with Default OpenGL driver (3dfx mini doesn't work good with wine and the installer script will disable it) and select resolution to match your Desktop, e.g. run it with game args:
-game bshift_unlocked -full -gl -gldrv Default -width 1920 -height 1080 -console

If you want to use Direct3D then you must run it in window mode, e.g.:
-game bshift_unlocked -window -d3d -width 1920 -height 1080 -console
because it is unstable in fullscreen mode.
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
- patch1001: 'N/A: Please manually download bspatch.exe (sha256: 829962bb2a7e345f3db8ee8c8181a611c743103c322550efdd711562eba43d62)'
- bsulpatch11: 'N/A: Please manually download bshift_unlocked_v1.1.exe (sha256: 0fa8663c8c4081e8f6dbea667d8ce2e7aff0fc31a9156ec2630c7143041fee10)'
game:
  arch: win32
  args: -game bshift_unlocked -full -gl -gldrv Default -width 1920 -height 1080 -console
  exe: $GAMEDIR/$gamepath/hl.exe
  prefix: $GAMEDIR
installer:
- insert-disc:
    requires: ../BLUE_SHIFT/setup.EXE
- write_file:
    content: '#!/bin/bash

      cddevice=$(mount | grep -m 1 BLUE_SHIFT | grep -oE "/dev/\w+"); mkdir -p "$GAMEDIR/$gamepath/bshift_unlocked/media";
      tracknames=("data" "Half-Life01.mp3" "Prospero01.mp3" "Half-Life12.mp3" "Half-Life07.mp3"
      "Half-Life10.mp3" "Suspense01.mp3" "Suspense03.mp3" "Half-Life09.mp3" "Half-Life02.mp3"
      "Half-Life13.mp3" "Half-Life04.mp3" "Half-Life15.mp3" "Half-Life14.mp3" "Half-Life16.mp3"
      "Suspense02.mp3" "Half-Life03.mp3" "Half-Life08.mp3" "Prospero02.mp3" "Half-Life05.mp3"
      "Prospero04.mp3" "Half-Life11.mp3" "Half-Life06.mp3" "Prospero03.mp3" "Half-Life17.mp3"
      "Prospero05.mp3" "Suspense05.mp3" "Suspense07.mp3"); for i in {2..20}; do cdda2wav
      -D "$cddevice" -t $i+$i - | lame -b 320 --id3v1-only - "$GAMEDIR/$gamepath/bshift_unlocked/media/${tracknames[$((i-1))]}";
      done

      '
    file: $CACHE/ripaudio.sh
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
    args: patch1001 $patch1001_sha256
    file: $CACHE/checkhash.sh
- execute:
    args: bsulpatch11 $bsulpatch11_sha256
    file: $CACHE/checkhash.sh
- task:
    arch: win32
    executable: $DISC/../BLUE_SHIFT/setup.EXE
    name: wineexec
    prefix: $GAMEDIR
- task:
    arch: win32
    executable: $DISC/../BLUE_SHIFT/upgradekit.EXE
    name: wineexec
    prefix: $GAMEDIR
- task:
    arch: win32
    executable: patch1001
    name: wineexec
    prefix: $GAMEDIR
- task:
    arch: win32
    executable: bsulpatch11
    name: wineexec
    prefix: $GAMEDIR
- execute:
    args: $CACHE/ripaudio.sh
    file: bash
- execute:
    args: -f "$GAMEDIR/drive_c/users/user/Desktop/Blue Shift.LNK"
    file: rm
- write_file:
    content: GL_texturemode GL_Nearest
    file: $GAMEDIR/$gamepath/bshift_unlocked/autoexec.cfg
require-binaries: sha256sum, cdda2wav, lame
requires: half-life
variables:
  bsulpatch11_sha256: 0fa8663c8c4081e8f6dbea667d8ce2e7aff0fc31a9156ec2630c7143041fee10
  gamepath: drive_c/SIERRA/Half-Life
  patch1001_sha256: 829962bb2a7e345f3db8ee8c8181a611c743103c322550efdd711562eba43d62
wine:
  Desktop: true
  dgvoodoo2: true

```

