### url

https://lutris.net/api/installers/star-wars-knights-of-the-old-cd

### game_slug

star-wars-knights-of-the-old-republic

### runner

wine

### version

CD

### description

Star Wars: Knights of the Old Republic Game of The Year 4 CD Edition

### notes

```
1. Rip all 4 CDs
2. Mount all 4 CDs
3. Proceed with installation
4. The script will find the 1st CD and start the installer executable
5. When prompted for the next CD, select the matching Wine virtual drive letter
6. Uncheck "View ReadMe-KotOR.txt" and "Play Star Wars..." boxes before clicking "Finish".
7. Patch 1.03 will install next, when it finishes it will automatically open the readme. Close the readme and patcher window to continue and complete the installation.

Note: Nocd patch (18KB) is automatically downloaded by the installer script and applied using bspatch. The patch will modify the installed swkotor.exe to match the GoG nocd version (resulting swkotor.exe sha256: 9c10e0450a6eeca417e036e3cde7474fed1f0a92aab018446d156944dea91435).
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
- patch103: http://static.dolimg.com/mh_netstorage/lucasfilm/patches/pc/SWKotOR1_03.exe
- nocdpatch_b64: https://www.klgrth.io/paste/e9bf5/raw
game:
  arch: win64
  exe: $GAMEDIR/$gamepath/swkotor.exe
  prefix: $GAMEDIR
installer:
- merge:
    dst: $CACHE/patch103
    src: patch103
- merge:
    dst: $CACHE/nocdpatch_b64
    src: nocdpatch_b64
- execute:
    command: echo "[INFO] Verifying SWKotOR1_03.exe (patch v1.03) sha256 checksum...";
      afunc() { [ $(sha256sum "$patch103" | cut -c 1-64) = $patch103_sha256 ]; };
      afunc;
- execute:
    command: echo "[INFO] SWKotOR1_03.exe checksum OK"
- execute:
    command: echo "[INFO] Preparing binary patch (18KB) for swkotor.exe..."; base64
      -d "$nocdpatch_b64" > "$CACHE/nocdpatch";
- execute:
    command: echo "[INFO] Verifying patch sha256 checksum..."; afunc() { [ $(sha256sum
      "$CACHE/nocdpatch" | cut -c 1-64) = $nocdpatch_sha256 ]; }; afunc;
- execute:
    command: echo "[INFO] nocdpatch checksum OK"
- task:
    arch: win64
    install_gecko: false
    install_mono: false
    name: create_prefix
    prefix: $GAMEDIR
- insert-disc:
    requires: ReadMe-KotOR.txt
- task:
    arch: win64
    executable: $DISC/Setup.exe
    name: wineexec
    prefix: $GAMEDIR
- task:
    arch: win64
    executable: patch103
    name: wineexec
    prefix: $GAMEDIR
- execute:
    command: echo "[INFO] Applying nocd patch to generate gog nocd swkotor.exe (v1.03)...";
      bspatch "$GAMEDIR/$gamepath/swkotor.exe" "$CACHE/swkotor.exe" "$CACHE/nocdpatch";
- execute:
    command: echo "[INFO] Verifying patched swkotor.exe (v1.03) sha256 checksum...";
      afunc() { [ $(sha256sum "$CACHE/swkotor.exe" | cut -c 1-64) = $swkotor_gog_sha256
      ]; }; afunc;
- execute:
    command: echo "[INFO] swkotor.exe checksum OK"
- execute:
    command: echo "[INFO] Overwriting installed swkotor.exe with patched swkotor.exe..."
      mv "$GAMEDIR/$gamepath/swkotor.exe" "$CACHE/swkotor.bak"; mv "$CACHE/swkotor.exe"
      "$GAMEDIR/$gamepath/swkotor.exe";
- execute:
    command: echo "[INFO] patched swkotor.exe copied successfully."; echo "[INFO]
      Installation complete.";
require-binaries: sha256sum, base64, bspatch
variables:
  gamepath: drive_c/Program Files/LucasArts/SWKotOR
  nocdpatch_sha256: 898f12d67bba8370912b22e0acf0dd5dc3989f6dbe0a8ce1657de4d3341be0f4
  patch103_sha256: 5192318ff9ae87b09f385a151ef32c00ba31e954c054ab68ade401d8f4c51c5a
  swkotor_gog_sha256: 9c10e0450a6eeca417e036e3cde7474fed1f0a92aab018446d156944dea91435

```

