### url

https://lutris.net/api/installers/the-curse-of-monkey-island-2-cd

### game_slug

the-curse-of-monkey-island

### runner

linux

### version

2 CD

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
- execute:
    command: mkdir -p "$GAMEDIR/gamefiles/resource"
- insert-disc:
    requires: ../MONKEY3_1/comi.la1
- execute:
    command: cp -rn "$DISC/../MONKEY3_1/"{resource,comi.*} "$GAMEDIR/gamefiles/"
- insert-disc:
    requires: ../MONKEY3_2/comi.la2
- execute:
    command: cp -rn "$DISC/../MONKEY3_2/"{resource,comi.*} "$GAMEDIR/gamefiles/"
require-binaries: scummvm
variables:
  scummid: scumm:comi
  scummlabel: comi

```

