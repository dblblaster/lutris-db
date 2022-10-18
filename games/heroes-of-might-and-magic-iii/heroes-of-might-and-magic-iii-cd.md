### url

https://lutris.net/api/installers/games/heroes-of-might-and-magic-iii/revisions/93105

### game_slug

heroes-of-might-and-magic-iii

### runner

wine

### version

CD

### description

Heroes III Complete 2 CD Version (includes Heroes III: The Restoration of Erathia, Heroes III: Armageddon's Blade, and Heroes III: Shadow of Death)

### notes

```
1. Rip both CDs (CDs 3 and 4 from Heroes of Might and Magic - Platinum Edition)
2. Mount both CDs
3. Proceed with installation

Note: Nocd patch (1KB) is automatically downloaded by the installer script and applied using bspatch. The patch will modify the installed HEROES3.EXE to match the GoG nocd version (resulting HEROES3.EXE sha256: b067f3c24467e8cd77f875f3cae4ebc9610d7989514261cbac0785f5c08ca751).
```

### content

```
files:
- nocdpatch_b64: https://www.klgrth.io/paste/a8oaw/raw
- cncddraw: https://github.com/FunkyFr3sh/cnc-ddraw/releases/download/v4.6.0.0/cnc-ddraw.zip
game:
  arch: win64
  exe: $GAMEDIR/$gamepath/HEROES3.EXE
  prefix: $GAMEDIR
installer:
- merge:
    dst: $CACHE/cncddraw
    src: cncddraw
- execute:
    command: echo "[INFO] Verifying cnc-ddraw.zip (v4.6.0.0) sha256 checksum...";
      afunc() { [ $(sha256sum "$cncddraw" | cut -c 1-64) = $cncddraw_sha256 ]; };
      afunc;
- execute:
    command: echo "[INFO] cnc-ddraw.zip checksum OK"
- merge:
    dst: $CACHE/nocdpatch_b64
    src: nocdpatch_b64
- execute:
    command: echo "[INFO] Preparing binary patch (1KB) for HEROES3.EXE..."; base64
      -d "$nocdpatch_b64" > "$CACHE/nocdpatch";
- execute:
    command: echo "[INFO] Verifying patch sha256 checksum..."; afunc() { [ $(sha256sum
      "$CACHE/nocdpatch" | cut -c 1-64) = $nocdpatch_sha256 ]; }; afunc;
- execute:
    command: echo "[INFO] nocdpatch checksum OK"
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
      bspatch "$GAMEDIR/$gamepath/HEROES3.EXE" "$CACHE/HEROES3.EXE" "$CACHE/nocdpatch";
- execute:
    command: echo "[INFO] Verifying gog nocd HEROES3.EXE (v4.0) sha256 checksum...";
      afunc() { [ $(sha256sum "$CACHE/HEROES3.EXE" | cut -c 1-64) = $swkotor2_gog_sha256
      ]; }; afunc;
- execute:
    command: echo "[INFO] HEROES3.EXE checksum OK"
- execute:
    command: echo "[INFO] Overwriting installed HEROES3.EXE with gog nocd HEROES3.EXE..."
      mv "$GAMEDIR/$gamepath/HEROES3.EXE" "$CACHE/HEROES3.bak"; mv "$CACHE/HEROES3.EXE"
      "$GAMEDIR/$gamepath/HEROES3.EXE";
- execute:
    command: echo "[INFO] gog nocd HEROES3.EXE copied successfully."; echo "[INFO]
      Installation complete.";
- execute:
    command: echo "[INFO] adding registry key to allow skipping cinematics on first
      run"
- task:
    key: First Time
    name: set_regedit
    path: "HKEY_LOCAL_MACHINE\\Software\\Wow6432Node\\New World Computing\\Heroes\
      \ of Might and Magic\xAE III\\1.0"
    type: REG_DWORD
    value: '00000000'
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

