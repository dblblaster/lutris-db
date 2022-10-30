### url

https://lutris.net/api/installers/games/warcraft-ii-battlenet-edition/revisions/93642

### game_slug

warcraft-ii-battlenet-edition

### runner

wine

### version

CD

### description

Installs the game from original CD. Applies the last official patch (v2.02-0). Patches a single byte in storm.dll to allow playing without the CD.

### notes

```
1. In original setup launcher, click the "Install Warcraft II" button, enter the CD key, and install to default folder
2. When it completes just click "Exit Installer" to continue
3. Patch will install next. When you click "OK" the patcher window will close but it will start the game. Exit the game (press ESC a few times) to complete lutris setup.
4. Normally launch the game from lutris
```

### credits

```
null
```

### reason

```
Change patch to v2.02-0 instead of v2.02-1. Notes: https://forum.war2.ru/index.php?topic=59.0
```

### content

```
files:
- patch202: https://ftp.war2.ru/war2/Fixes%20&%20Patches/Original%202.0.2.0%20patch/w2bne2020.zip
- cncddraw: https://github.com/FunkyFr3sh/cnc-ddraw/releases/download/v4.6.0.0/cnc-ddraw.zip
game:
  arch: win32
  exe: $GAMEDIR/$gamepath/Warcraft II BNE.exe
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
    dst: $CACHE/patch202
    src: patch202
- execute:
    args: $CACHE/patch202/W2BNE202.exe $patch202_sha256
    file: $CACHE/checkhash.sh
- insert-disc:
    requires: ../WAR2BNECD/setup.exe
- task:
    arch: win32
    install_gecko: false
    install_mono: false
    name: create_prefix
    prefix: $GAMEDIR
- task:
    executable: $DISC/../WAR2BNECD/setup.exe
    name: wineexec
    prefix: $GAMEDIR
- task:
    executable: $CACHE/patch202/W2BNE202.exe
    name: wineexec
    prefix: $GAMEDIR
- execute:
    args: $GAMEDIR/$gamepath/Patch_W2.mpq $GAMEDIR/$gamepath/War2Patch.mpq
    file: mv
- execute:
    args: -n $DISC/../WAR2BNECD/install.exe $GAMEDIR/$gamepath
    file: cp
- execute:
    command: printf "\xeb" | dd of="$GAMEDIR/$gamepath/storm.dll" bs=1 count=1 seek=99962
      conv=notrunc
- task:
    key: War2CD
    name: set_regedit
    path: HKEY_LOCAL_MACHINE\Software\Blizzard Entertainment\Warcraft II BNE
    type: REG_SZ
    value: $gamepathwin
- extract:
    dst: $GAMEDIR/$gamepath
    src: cncddraw
require-binaries: sha256sum
variables:
  cncddraw_sha256: 1633d30bc80ecae60db97e881a4c804911e300dcb280d58ea8b8ddda2e1dd1ac
  gamepath: drive_c/Program Files/Warcraft II BNE
  gamepathwin: C:\\Program Files\\Warcraft II BNE
  patch202_sha256: b06d636ac68b25e05ebe38e0835328c3fbf375352082cf607d695331df4408e4
wine:
  overrides:
    ddraw.dll: n

```

