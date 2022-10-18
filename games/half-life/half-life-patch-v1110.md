### url

https://lutris.net/api/installers/games/half-life/revisions/93108

### game_slug

half-life

### runner

wine

### version

Patch v1.1.1.0

### description

This updates the game to the last World Opponent Network (WON) non-Steam version. Use only if you do not intend to install Half-Life: Opposing Force. Patches Half-Life to v1.1.1.0. Applies community resolution/FoV/mp3 patch v1.1.2.

### notes

```
Game patches can be found inside this archive (1.58 GB): https://www.moddb.com/games/counter-strike/downloads/half-life-updates-pre-post-1100
Download it once and keep it at hand, installer script will ask for it.

Community resolution/FoV/mp3 patch v1.1.2 can be found here: https://www.moddb.com/downloads/half-life-won-resolution-fov-mp3-patch
Download it once and keep it at hand, installer script will ask for it.

Installer script will first verify that you got the correct files. It will then proceed to apply patches in correct sequence according to instructions from the 1st archive.

Run the game with Default OpenGL driver (3dfx mini doesn't work good with wine and the installer script will disable it) and select resolution to match your Desktop, e.g. run it with game args:
-full -gl -gldrv Default -width 1920 -height 1080 -console

If you want to use Direct3D then you must run it in window mode, e.g.:
-window -d3d -width 1920 -height 1080 -console
because it is unstable in fullscreen mode.
```

### content

```
extends: half-life
files:
- patchpack1110: 'N/A: Please manually download Half-Life_Counter-Strike_Updates_Pre_1.1.0.0_Update_Archive.7z
    (sha256: 6f63aba5ab0cd125db1488ec5275ade96911c4eb150837486bc25adf3d67964e)'
- fovpatch112: 'N/A: Please manually download Half-Life_WON_Resolution_FOV_MP3_Patch_v1.1.2.zip
    (sha256: 80229881e6b70829a0486feb447a6e6e24261bd219ebfea05069b565081d7caa)'
game:
  arch: win32
  args: -full -gl -gldrv Default -width 1920 -height 1080 -console
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
    dst: $CACHE/patchpack1110
    src: patchpack1110
- extract:
    dst: $CACHE/patchpack1110/
    file: patchpack1110
- execute:
    args: '"$CACHE/patchpack1110/Official Updates/Half-Life/Half-Life V1.1.0.4/hl1104.exe"
      $patch1104_sha256'
    file: $CACHE/checkhash.sh
- execute:
    args: '"$CACHE/patchpack1110/Official Updates/Half-Life/Half-Life V1.1.0.4 To
      V1.1.0.8/11041106.exe" $patch11041106_sha256'
    file: $CACHE/checkhash.sh
- execute:
    args: '"$CACHE/patchpack1110/Official Updates/Half-Life/Half-Life V1.1.0.4 To
      V1.1.0.8/11061107.exe" $patch11061107_sha256'
    file: $CACHE/checkhash.sh
- execute:
    args: '"$CACHE/patchpack1110/Official Updates/Half-Life/Half-Life V1.1.0.4 To
      V1.1.0.8/11071108.exe" $patch11071108_sha256'
    file: $CACHE/checkhash.sh
- execute:
    args: '"$CACHE/patchpack1110/Official Updates/Half-Life/Half-Life V1.1.0.8 To
      V1.1.1.0/11081109.exe" $patch11081109_sha256'
    file: $CACHE/checkhash.sh
- execute:
    args: '"$CACHE/patchpack1110/Official Updates/Half-Life/Half-Life V1.1.0.8 To
      V1.1.1.0/11091110.exe" $patch11091110_sha256'
    file: $CACHE/checkhash.sh
- merge:
    dst: $CACHE/fovpatch112
    src: fovpatch112
- execute:
    args: fovpatch112 fovpatch112_sha256
    file: $CACHE/checkhash.sh
- task:
    arch: win32
    executable: '"$CACHE/patchpack1110/Official Updates/Half-Life/Half-Life V1.1.0.4/hl1104.exe"'
    name: wineexec
    prefix: $GAMEDIR
- task:
    arch: win32
    executable: '"$CACHE/patchpack1110/Official Updates/Half-Life/Half-Life V1.1.0.4
      To V1.1.0.8/11041106.exe"'
    name: wineexec
    prefix: $GAMEDIR
- task:
    arch: win32
    executable: '"$CACHE/patchpack1110/Official Updates/Half-Life/Half-Life V1.1.0.4
      To V1.1.0.8/11061107.exe"'
    name: wineexec
    prefix: $GAMEDIR
- task:
    arch: win32
    executable: '"$CACHE/patchpack1110/Official Updates/Half-Life/Half-Life V1.1.0.4
      To V1.1.0.8/11071108.exe"'
    name: wineexec
    prefix: $GAMEDIR
- task:
    arch: win32
    executable: '"$CACHE/patchpack1110/Official Updates/Half-Life/Half-Life V1.1.0.8
      To V1.1.1.0/11081109.exe"'
    name: wineexec
    prefix: $GAMEDIR
- task:
    arch: win32
    executable: '"$CACHE/patchpack1110/Official Updates/Half-Life/Half-Life V1.1.0.8
      To V1.1.1.0/11091110.exe"'
    name: wineexec
    prefix: $GAMEDIR
- extract:
    dst: $CACHE/fovpatch112/
    file: fovpatch112
- merge:
    dst: $GAMEDIR/$gamepath
    src: $CACHE/fovpatch112/Half-Life/1.1.1.0
- move:
    dst: $GAMEDIR/$gamepath/gldrv/drvmap.txt.disabled
    src: $GAMEDIR/$gamepath/gldrv/drvmap.txt
- write_file:
    content: GL_texturemode GL_Nearest
    file: $GAMEDIR/$gamepath/valve/autoexec.cfg
require-binaries: sha256sum
variables:
  fovpatch112_sha256: 80229881e6b70829a0486feb447a6e6e24261bd219ebfea05069b565081d7caa
  gamepath: drive_c/SIERRA/Half-Life
  patch11041106_sha256: 569c9af60a792df30778a46cd98872072e34736fc3a71515526df759be3ccf41
  patch1104_sha256: 5c93a53000b53ca8ecdc4b821056022f304f9e044d38b931df6a52380ad69eac
  patch11061107_sha256: f153b26d5ae42eb42ae6e1522bf97b68d19a1cc114a8e97242de1d0e2db003ec
  patch11071108_sha256: 70c9831e440af01daa27038597180b7a6cdad2372aa618e80a8c150dd1e6a168
  patch11081109_sha256: 3a8fbbc336e27c36927097f26fb31f2bb066f72fd771f06f6d21ffc6b79cf7f9
  patch11091110_sha256: e5f0bfc96a63fc1ea699cf65ac9d087ea62695f26865921d7d2b60c23dfb98d7
wine:
  Desktop: true
  dgvoodoo2: true

```

