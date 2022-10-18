### url

https://lutris.net/api/installers/games/starcraft-brood-war/revisions/92988

### game_slug

starcraft-brood-war

### runner

wine

### version

Battle Chest 2 CD

### description

Installs both StarCraft and StartCraft: Brood War. Patches to 1.16.1.

### notes

```
Installer will automatically install both StartCraft and StarCraft: Brood War

1. Rip both CDs
2. Mount both CDs
3. Proceed with installation
4. The script will find the 1st CD and start the installer executable
5. The installer will automatically find the 2nd CD
6. Patch 1.16.1 will install next, when it finishes it will automatically open the readme. Close the readme and patcher window to continue and complete the installation.
```

### content

```
files:
- patch1161: https://web.archive.org/web/20140908015808/http://ftp.blizzard.com/pub/starcraft/patches/PC/SC-1161.exe
- cncddraw: https://github.com/FunkyFr3sh/cnc-ddraw/releases/download/v4.6.0.0/cnc-ddraw.zip
game:
  arch: win64
  exe: $GAMEDIR/$gamepath/StarCraft.exe
  prefix: $GAMEDIR
installer:
- merge:
    dst: $CACHE/patch1161
    src: patch1161
- execute:
    command: echo "[INFO] Verifying SC-1161.exe (patch v1.16.1) sha256 checksum...";
      afunc() { [ $(sha256sum "$patch1161" | cut -c 1-64) = $patch1161_sha256 ]; };
      afunc;
- execute:
    command: echo "[INFO] SC-1161.exe checksum OK"
- merge:
    dst: $CACHE/cncddraw
    src: cncddraw
- execute:
    command: echo "[INFO] Verifying cnc-ddraw.zip (v4.6.0.0) sha256 checksum...";
      afunc() { [ $(sha256sum "$cncddraw" | cut -c 1-64) = $cncddraw_sha256 ]; };
      afunc;
- execute:
    command: echo "[INFO] cnc-ddraw.zip checksum OK"
- insert-disc:
    requires: Installer Tome.mpq
- task:
    arch: win64
    install_gecko: false
    install_mono: false
    name: create_prefix
    prefix: $GAMEDIR
- task:
    arch: win64
    executable: $DISC/StarCraft (Windows).exe
    name: wineexec
    prefix: $GAMEDIR
- task:
    arch: win64
    executable: patch1161
    name: wineexec
    prefix: $GAMEDIR
- extract:
    dst: $GAMEDIR/$gamepath
    src: cncddraw
- execute:
    command: echo "[INFO] Disabling battle.net updater (bnupdate.exe renamed to bnupdate.exe.disabled)...";
      mv "$GAMEDIR/$gamepath/bnupdate.exe" "$GAMEDIR/$gamepath/bnupdate.exe.disabled"
require-binaries: sha256sum
variables:
  cncddraw_sha256: 1633d30bc80ecae60db97e881a4c804911e300dcb280d58ea8b8ddda2e1dd1ac
  gamepath: drive_c/Program Files (x86)/StarCraft
  patch1161_sha256: 755b4dbe3f8a928831b19bfa975445885b8c1760ffa4e5a795d37e7f02e6c31e
wine:
  overrides:
    ddraw.dll: n

```

