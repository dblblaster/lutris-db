### url

https://lutris.net/api/installers/games/the-curse-of-monkey-island/revisions/93094

### game_slug

the-curse-of-monkey-island

### runner

linux

### version

2 CD

### description

Made to run using system's scummvm binary. Persistent scummvm config stored in game directory.

### notes

```
Requires scummvm (https://www.scummvm.org/) package for your Linux distribution to be installed.
```

### content

```
game:
  args: --fullscreen $scummgame
  exe: $GAMEDIR/$scummgame.sh
installer:
- execute:
    command: mkdir -p $GAMEDIR/gamefiles
- execute:
    command: mkdir -p $GAMEDIR/savegames
- write_file:
    content: '#!/bin/bash

      scummvm --config=scummvm.ini --savepath=savegames --path=gamefiles --add --game=$scummgame

      scummvm --config=scummvm.ini --savepath=savegames --path=gamefiles $@

      '
    file: $GAMEDIR/$scummgame.sh
- execute:
    args: +x $GAMEDIR/$scummgame.sh
    file: chmod
- execute:
    command: mkdir -p $GAMEDIR/gamefiles/resource
- insert-disc:
    requires: ../MONKEY3_1/comi.la1
- execute:
    command: cp -rn $DISC/../MONKEY3_1/{resource,comi.*} $GAMEDIR/gamefiles/
- insert-disc:
    requires: ../MONKEY3_2/comi.la2
- execute:
    command: cp -rn $DISC/../MONKEY3_2/{resource,comi.*} $GAMEDIR/gamefiles/
require-binaries: scummvm
variables:
  scummgame: comi

```

