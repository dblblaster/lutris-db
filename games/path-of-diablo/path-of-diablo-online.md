### url

https://lutris.net/api/installers/games/path-of-diablo/revisions/93106

### game_slug

path-of-diablo

### runner

wine

### version

Online

### description

Requires Diablo II: Lord of Destruction

### notes

```
This will install Path of Diablo on top of Diablo II: Lord of Destruction. It requires the original game to be already installed by lutris but it will install in a new prefix and it will NOT touch original game files - PoD will live in its own folder.

1. Diablo II: Lord of Destruction installation must be present. Symbolic links that point to original game files will be created inside a new wine prefix created for Path of Diablo.
2. Path of Diablo installer will require you to manually select path of the original game, just point it to "C:\Program Files\Diablo II"
3. When installation completes, launcher will download additional files and update the modded game to latest version
4. Upon first launch, click the cogwheel button next to "-3dfx" option and check:
  - captured mouse
  - keep aspect ratio
  - desktopresolution

Installer is automating installation steps described here: https://pathofdiablo.com/wiki/index.php?title=Linux
Note: PoD ships with a custom glide3x.dll (upstream source: https://www.svenswrapper.de/english/whatis.html) and the modded game has been tailored to work with it. The modded game is NOT compatible with direct3d or dgvoodo2.
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
- merge:
    dst: $CACHE/podinstaller
    src: podinstaller
- execute:
    command: echo "[INFO] Verifying pathofdiablolauncher.msi sha256 checksum...";
      afunc() { [ $(sha256sum "$podinstaller" | cut -c 1-64) = $podinstaller_sha256
      ]; }; afunc;
- execute:
    command: echo "[INFO] pathofdiablolauncher.msi checksum OK"
- execute:
    command: mkdir -p "$GAMEDIR/$podpath"
- execute:
    command: 'echo "[INFO] Looking for Diablo II: Lord of Destruction installation
      in "$(cd "$GAMEDIR/.." && pwd)/diablo-ii-lord-of-destruction ...'
- execute:
    command: echo "[INFO] Found $GAMEDIR/$d2path, proceeding with Path of Diablo installation..."
- execute:
    command: if [ -d "$GAMEDIR/$d2path32" ]; then d2path="$d2path32"; fi; if [ -d
      "$GAMEDIR/$d2path64" ]; then d2path="$d2path64"; fi; if [ -z "$d2path" ]; then
      false; else ln -sr -t "$GAMEDIR/$podpath/" "$GAMEDIR/$d2path"/{*.mpq,Game.exe,D2.LNG};
      fi;
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
variables:
  d2path32: ../diablo-ii-lord-of-destruction/drive_c/Program Files/Diablo II
  d2path64: ../diablo-ii-lord-of-destruction/drive_c/Program Files (x86)/Diablo II
  podinstaller_sha256: 5ae13a26dea0507c8aff7da53992e86bd76956f8983d0bc71198d9eb98ea475a
  podpath: drive_c/Program Files/Diablo II

```

