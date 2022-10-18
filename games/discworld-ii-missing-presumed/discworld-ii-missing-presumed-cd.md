### url

https://lutris.net/api/installers/games/discworld-ii-missing-presumed/revisions/92984

### game_slug

discworld-ii-missing-presumed

### runner

scummvm

### version

CD

### description

2 CD English release (Europe)

### notes

```

```

### content

```
game:
  game_id: tinsel:dw2
  path: $GAMEDIR
installer:
- insert-disc:
    requires: ../DW2CD1_ENG/dw2win.exe
- execute:
    command: cp -n $DISC/../DW2CD1_ENG/dw2/{*.bmv,*.cdp,*.mus,*.scn,gdata,hopper,index,../sample.bnk}
      $GAMEDIR/
- execute:
    command: for i in $DISC/../DW2CD1_ENG/dw2/english.*; do cp -n $i $GAMEDIR/english1.$(basename
      $i | cut -d. -f2); done
- insert-disc:
    requires: ../DW2_CD1_ENG/dw2win.exe
- execute:
    command: cp -n $DISC/../DW2_CD1_ENG/dw2/{*.bmv,*.cdp,*.mus,*.scn,gdata,hopper,index,../sample.bnk}
      $GAMEDIR/
- execute:
    command: for i in $DISC/../DW2_CD1_ENG/dw2/english.*; do cp -n $i $GAMEDIR/english2.$(basename
      $i | cut -d. -f2); done
scummvm:
  aspect: false
  fullscreen: true
  subtitles: true

```

