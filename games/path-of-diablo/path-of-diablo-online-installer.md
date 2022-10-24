### url

https://lutris.net/api/installers/path-of-diablo-online-installer

### game_slug

path-of-diablo

### runner

wine

### version

Online Installer

### description

Requires Diablo II: Lord of Destruction to be already installed.

### notes

```
This will install Path of Diablo on top of Diablo II: Lord of Destruction. It requires the original game to be already installed but it will install in a new prefix and it will NOT touch original game files - PoD will live in its own folder but it will read game files (*.mpq, Game.exe, D2.LNG) from your Diablo II: LoD installation.

1. Diablo II: Lord of Destruction installation must be present and you will be asked to select the folder which contains the installed game files. Relative path symbolic links that point to original game files will be created inside a new wine prefix created for Path of Diablo.
2. Path of Diablo installer will require you to manually select path of the original game, just point it to "C:\Program Files\Diablo II" (it will look like an empty folder, that's ok).
3. When installation completes, installer will offer to start the launcher. Uncheck that, do not start yet, and just click "Finish" to complete the installation script.

When you first start the game from lutris, PoD launcher will download its game files. When it completes, select either -3dfx or -ddraw option and click "Launch" to start the game.

Installer is automating installation steps described here: https://pathofdiablo.com/wiki/index.php?title=Linux
Note: PoD ships with a custom glide3x.dll (upstream source: https://www.svenswrapper.de/english/whatis.html) and with a specific version of cnc-ddraw (upstream source: https://github.com/FunkyFr3sh/cnc-ddraw). The modded game has been tailored to work with those. The modded game is NOT compatible with lutris direct3d or dgvoodo2 and attempting to remove ddraw.dll override and use system's ddraw.dll will result in game crashes.
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
- podinstaller: https://pathofdiablo.com/pathofdiablolauncher.msi
game:
  arch: win32
  exe: $GAMEDIR/$podpath/Path of Diablo/Path of Diablo Launcher.exe
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
    args: podinstaller $podinstaller_sha256
    file: $CACHE/checkhash.sh
- execute:
    command: mkdir -p "$GAMEDIR/$podpath"
- insert-disc:
    message: 'Please select a folder where you have Diablo II: Lord of Distruction
      installed (e.g. "~Games/diablo-ii-lord-of-destruction/drive_c/Program Files
      (x86)/Diablo II/"). The installer script will then make symbolic links to game
      files there, using relative paths, so that they may be read by Path of Diablo.'
    requires: d2exp.mpq
- execute:
    command: ln -sr -t "$GAMEDIR/$podpath/" "$DISC"/{*.mpq,Game.exe,D2.LNG};
- task:
    arch: win32
    install_gecko: false
    install_mono: false
    name: create_prefix
    prefix: $GAMEDIR
- task:
    app: dotnet40
    name: winetricks
    silent: true
- task:
    arch: win32
    executable: podinstaller
    name: wineexec
    prefix: $GAMEDIR
- task:
    key: capturedmouse
    name: set_regedit
    path: HKEY_CURRENT_USER\Software\GLIDE3toOpenGL
    type: REG_DWORD
    value: '00000001'
- task:
    key: desktopresolution
    name: set_regedit
    path: HKEY_CURRENT_USER\Software\GLIDE3toOpenGL
    type: REG_DWORD
    value: '00000001'
- task:
    key: english
    name: set_regedit
    path: HKEY_CURRENT_USER\Software\GLIDE3toOpenGL
    type: REG_DWORD
    value: '00000001'
variables:
  podinstaller_sha256: 5ae13a26dea0507c8aff7da53992e86bd76956f8983d0bc71198d9eb98ea475a
  podpath: drive_c/Program Files/Diablo II
wine:
  overrides:
    ddraw.dll: n

```

