### url

https://lutris.net/api/installers/star-wars-knights-of-the-old-cd-1

### game_slug

star-wars-knights-of-the-old-republic-ii

### runner

wine

### version

CD

### description

Patches to v1.0b and applies nocd patch.

### notes

```
1. Rip all 4 CDs
2. Mount all 4 CDs
3. Manually download v1.0b patch (sw_pc_english_from200424_to210427.exe), lutris installer will ask for it. It is available at: https://games.softpedia.com/get/Patch/Star-Wars-Knights-of-the-Old-Republic-II-the-Sith-Lords-Patch.shtml (they don't support direct download links, so couldn't automate the download) (sha256: 543ed01f7d4c9bcdd5efff9c8dc29e72686192ec4819cbe476016e084341b74b).
4. Proceed with installation
5. The script will find the 1st CD and start the installer executable
6. When prompted for the next CD, select the matching Wine virtual drive letter
7. Be sure to uncheck "View the Readme" and "Play Star Wars..." boxes before clicking "Finish".
8. Patch 1.0b will install next, when it finishes it will automatically open the readme. Close the readme and the patch installer window to continue and complete the installation.

Note: The downloaded nocd patch (282KB) is applied using bspatch. The patch will modify the installed swkotor2.exe to match the GoG nocd version (resulting swkotor2.exe sha256: 0912d1942de4ee849f06588cb738a0e78b6d5ffe92960b9567196d54b7e808d0).
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
- patch10b: 'N/A: Please manually download sw_pc_english_from200424_to210427.exe (sha256:
    543ed01f7d4c9bcdd5efff9c8dc29e72686192ec4819cbe476016e084341b74b)'
- nocdpatch_b64: https://www.klgrth.io/paste/5rpyd/raw
game:
  arch: win64
  exe: $GAMEDIR/$gamepath/swkotor2.exe
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
    args: patch10b $patch10b_sha256
    file: $CACHE/checkhash.sh
- execute:
    command: echo "[INFO] Preparing binary patch (282KB) for swkotor2.exe..."; base64
      -d <(cat "$nocdpatch_b64") > "$CACHE/nocdpatch_b64/nocdpatch.bin";
- execute:
    args: $CACHE/nocdpatch_b64/nocdpatch.bin $nocdpatch_sha256
    file: $CACHE/checkhash.sh
- insert-disc:
    requires: ../KOTOR2_1/swkotor2.exe
- insert-disc:
    requires: ../KOTOR2_2/data3.cab
- insert-disc:
    requires: ../KOTOR2_3/data4.cab
- insert-disc:
    requires: ../KOTOR2_4/data5.cab
- task:
    arch: win64
    install_gecko: false
    install_mono: false
    name: create_prefix
    prefix: $GAMEDIR
- task:
    arch: win64
    executable: $DISC/../KOTOR2_1/setup.exe
    name: wineexec
    prefix: $GAMEDIR
- execute:
    command: echo "[INFO] Applying the patch to generate gog nocd swkotor2.exe (v1.0b)...";
      bspatch "$GAMEDIR/$gamepath/swkotor2.exe" "$CACHE/swkotor2.exe" "$CACHE/nocdpatch_b64/nocdpatch.bin";
- execute:
    args: $CACHE/swkotor2.exe $swkotor2_gog_sha256
    file: $CACHE/checkhash.sh
- task:
    arch: win64
    executable: patch10b
    name: wineexec
    prefix: $GAMEDIR
- execute:
    command: echo "[INFO] Overwriting installed swkotor2.exe with patched swkotor2.exe..."
      mv "$GAMEDIR/$gamepath/swkotor2.exe" "$CACHE/swkotor2.bak"; mv "$CACHE/swkotor2.exe"
      "$GAMEDIR/$gamepath/swkotor2.exe";
- execute:
    command: echo "[INFO] patched swkotor2.exe copied successfully."; echo "[INFO]
      Installation complete.";
require-binaries: sha256sum, base64, bspatch
variables:
  gamepath: drive_c/Program Files (x86)/LucasArts/SWKotOR2
  nocdpatch_sha256: c83ea356930efe96d9df60af37a8216b9b290c997c45c6e6240d310291b0e261
  patch10b_sha256: 543ed01f7d4c9bcdd5efff9c8dc29e72686192ec4819cbe476016e084341b74b
  swkotor2_gog_sha256: 0912d1942de4ee849f06588cb738a0e78b6d5ffe92960b9567196d54b7e808d0

```

