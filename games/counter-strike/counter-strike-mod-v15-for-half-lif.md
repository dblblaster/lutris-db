### url

https://lutris.net/api/installers/games/counter-strike/revisions/93111

### game_slug

counter-strike

### runner

wine

### version

Mod v1.5 for Half-Life v1.1.1.0

### description

This installs the last World Opponent Network (WON) non-Steam mod version of Counter-Strike.

### notes

```
Requires Half-Life v1.1.1.0 and assumes community resolution/FoV/mp3 patch v1.1.2 has been applied.

Run the game with Default OpenGL driver and select resolution to match your Desktop, e.g. run it with game args:
-game cstrike -full -gl -gldrv Default -width 1920 -height 1080 -console

If you want to use Direct3D then you must run it in window mode, e.g.:
-game cstrike -window -d3d -width 1920 -height 1080 -console
because it is unstable in fullscreen mode.
```

### content

```
files:
- csv15: 'N/A: Please manually download csv15full.exe (sha256: 2963e480b02e5e29b2577d897ce99355d863d7db580b5d670e070baa2be3a0e5)'
game:
  arch: win32
  args: -game cstrike -full -gl -gldrv Default -width 1920 -height 1080 -console
  exe: $GAMEDIR/$gamepath/hl.exe
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
- merge:
    dst: $CACHE/csv15
    src: csv15
- execute:
    args: '"csv15" $csv15_sha256'
    file: $CACHE/checkhash.sh
- task:
    arch: win32
    executable: csv15
    name: wineexec
    prefix: $GAMEDIR
- write_file:
    content: GL_texturemode GL_Nearest
    file: $GAMEDIR/$gamepath/cstrike/autoexec.cfg
require-binaries: sha256sum
requires: half-life
variables:
  csv15_sha256: 2963e480b02e5e29b2577d897ce99355d863d7db580b5d670e070baa2be3a0e5
  gamepath: drive_c/SIERRA/Half-Life
wine:
  Desktop: true
  dgvoodoo2: true

```

