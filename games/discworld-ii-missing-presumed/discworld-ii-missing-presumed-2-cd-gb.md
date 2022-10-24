### url

https://lutris.net/api/installers/discworld-ii-missing-presumed-2-cd-gb

### game_slug

discworld-ii-missing-presumed

### runner

linux

### version

2 CD (GB)

### description

Creates launcher script that uses system's scummvm binary and stores persistent config in game directory.

### notes

```
Requires scummvm (https://www.scummvm.org/) package for your Linux distribution to be installed.
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
  args: --fullscreen $scummlabel
  exe: $GAMEDIR/$scummlabel.sh
installer:
- execute:
    args: -p $GAMEDIR/gamefiles
    file: mkdir
- execute:
    args: -p $GAMEDIR/savegames
    file: mkdir
- write_file:
    content: '#!/bin/bash

      scummvm --config=scummvm.ini --savepath=savegames --path=gamefiles --add --game=$scummid

      scummvm --config=scummvm.ini --savepath=savegames --path=gamefiles $@

      '
    file: $GAMEDIR/$scummlabel.sh
- execute:
    args: +x $GAMEDIR/$scummlabel.sh
    file: chmod
- insert-disc:
    requires: ../DW2CD1_ENG/dw2win.exe
- execute:
    command: cp -n "$DISC/../DW2CD1_ENG/dw2/"{*.bmv,*.cdp,*.mus,*.scn,gdata,hopper,index,../sample.bnk}
      "$GAMEDIR/gamefiles/"
- execute:
    command: for i in "$DISC/../DW2CD1_ENG/dw2/"english.*; do cp -n "$i" "$GAMEDIR/gamefiles/english1.$(basename
      "$i" | cut -d. -f2)"; done
- insert-disc:
    requires: ../DW2_CD1_ENG/dw2win.exe
- execute:
    command: cp -n "$DISC/../DW2_CD1_ENG/dw2/"{*.bmv,*.cdp,*.mus,*.scn,gdata,hopper,index,../sample.bnk}
      "$GAMEDIR/gamefiles/"
- execute:
    command: for i in "$DISC/../DW2_CD1_ENG/dw2/"english.*; do cp -n "$i" "$GAMEDIR/gamefiles/english2.$(basename
      "$i" | cut -d. -f2)"; done
require-binaries: scummvm
variables:
  scummid: tinsel:dw2
  scummlabel: dw2-gb

```

