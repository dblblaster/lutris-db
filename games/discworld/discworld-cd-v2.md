### url

https://lutris.net/api/installers/games/discworld/revisions/93127

### game_slug

discworld

### runner

linux

### version

CD v2

### description

Made to run using system's scummvm binary. Persistent scummvm config stored in game directory.

### notes

```
Requires scummvm (https://www.scummvm.org/) package for your Linux distribution to be installed.

Doesn't require any patches, this version (CD v2, Discworld: The Directors Cut) shipped with all bugs fixed.
Version information: https://www.us.lspace.org/games/discworld/faq.html#part2.3
```

### content

```
game:
  args: --fullscreen $scummlabel
  exe: $GAMEDIR/$scummlabel.sh
installer:
- execute:
    command: mkdir -p $GAMEDIR/gamefiles
- execute:
    command: mkdir -p $GAMEDIR/savegames
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
    requires: ../DISCWORLD/dwu.exe
- execute:
    command: cp "$DISC/../DISCWORLD/discwld/"{*.idx,*.scn,*.smp,*.txt,midi.dat,index,../drivers/sample.ad,../drivers/sample.opl}
      "$GAMEDIR/gamefiles/"
require-binaries: scummvm
variables:
  scummid: tinsel:dw
  scummlabel: dw-cd

```

