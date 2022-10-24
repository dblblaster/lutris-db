### url

https://lutris.net/api/installers/ricochet-bundled-with-half-li

### game_slug

ricochet

### runner

wine

### version

Bundled with Half-Life v1.1.1.0

### description

This is a launcher for the mod that's included with Half-Life. This is for the last World Opponent Network (WON) non-Steam version of Half-Life (v1.1.1.0).

### notes

```
Requires Half-Life v1.1.1.0 and assumes community resolution/FoV/mp3 patch v1.1.2 has been applied.

Run the game with Default OpenGL driver and select resolution to match your Desktop, e.g. run it with game args:
-game ricochet -full -gl -gldrv Default -width 1920 -height 1080 -console

If you want to use Direct3D then you must run it in window mode, e.g.:
-game ricochet -window -d3d -width 1920 -height 1080 -console
because it is unstable in fullscreen mode.
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
game:
  arch: win32
  args: -game ricochet -full -gl -gldrv Default -width 1920 -height 1080 -console
  exe: $GAMEDIR/$gamepath/hl.exe
  prefix: $GAMEDIR
installer:
- write_file:
    content: GL_texturemode GL_Nearest
    file: $GAMEDIR/$gamepath/ricochet/autoexec.cfg
requires: half-life
variables:
  gamepath: drive_c/SIERRA/Half-Life
wine:
  Desktop: true
  dgvoodoo2: true

```

