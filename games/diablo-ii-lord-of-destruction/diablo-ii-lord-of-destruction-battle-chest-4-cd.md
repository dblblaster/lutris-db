### url

https://lutris.net/api/installers/diablo-ii-lord-of-destruction-battle-chest-4-cd

### game_slug

diablo-ii-lord-of-destruction

### runner

wine

### version

Battle Chest 4 CD

### description

This installs both Diablo II and Diablo II: Lord of Destruction (v1.12) from the 4 CDs. Install script provides patch options: v1.12, v1.13c, or v1.14d.

### notes

```
This edition requires 26-character CD-keys, one for original Diablo II and one for the expansion pack.

1. Rip all 4 CDs
2. Mount all 4 CDs
3. Run the installer
4. When Diablo II installation completes, exit the installer to continue.
5. When Diablo II: Lord of Destruction completes, exit the installer to continue.
6. Select patch version from the drop-down menu.
7. If patch was applied it will auto-start the game. Exit the game to complete the installation.
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
- patch113c: http://ftp.blizzard.com/pub/diablo2exp/patches/PC/LODPatch_113c.exe
- patch114d: http://ftp.blizzard.com/pub/diablo2exp/patches/PC/LODPatch_114d.exe
game:
  arch: win64
  exe: $GAMEDIR/$gamepath/Diablo II.exe
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
    args: patch113c $patch113c_sha256
    file: $CACHE/checkhash.sh
- execute:
    args: -n patch113c $CACHE/patch113c/LODPatch_113c.exe
    file: cp
- execute:
    args: patch114d $patch114d_sha256
    file: $CACHE/checkhash.sh
- execute:
    args: -n patch114d $CACHE/patch114d/LODPatch_114d.exe
    file: cp
- insert-disc:
    requires: ../Diablo II Disc 1/installer tome.mpq
- insert-disc:
    requires: ../Diablo II Disc 2/installer tome 2.mpq
- insert-disc:
    requires: ../Diablo II Disc 3/installer tome 3.mpq
- task:
    arch: win64
    install_gecko: false
    install_mono: false
    name: create_prefix
    prefix: $GAMEDIR
- task:
    arch: win64
    executable: $DISC/../Diablo II Disc 1/installer.exe
    name: wineexec
    prefix: $GAMEDIR
- insert-disc:
    requires: ../Diablo II LOD/installer tome.mpq
- task:
    arch: win64
    executable: $DISC/../Diablo II LOD/installer.exe
    name: wineexec
    prefix: $GAMEDIR
- input_menu:
    description: 'Choose the game''s patch version:'
    id: PATCHVER
    options:
    - 112: Keep the currently installed version (1.12)
    - 113c: Install the 1.13c patch
    - 114d: Install the 1.14d patch
    preselect: 114d
- execute:
    command: if [ "$INPUT" = "112" ]; then echo "[INFO] Keeping version 1.12"; else
      echo "[INFO] Installing LODPatch_$INPUT.exe"; WINEPREFIX=$GAMEDIR WINEARCH=win64
      $WINEBIN "$CACHE/patch$INPUT/LODPatch_$INPUT.exe"; fi
require-binaries: sha256sum
variables:
  gamepath: drive_c/Program Files (x86)/Diablo II
  patch113c_sha256: 2301158bb44062094e8dbfbe40dde6f20f870fc88190975c34379280e7aef781
  patch114d_sha256: 5ee5b6f09c338324db14ea3ec03a4b8a9b36e4eea249bb12f1fb592558d6434d
wine:
  dgvoodoo2: true

```

