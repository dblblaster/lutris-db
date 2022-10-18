### url

https://lutris.net/api/installers/games/discworld/revisions/92986

### game_slug

discworld

### runner

scummvm

### version

CD v2

### description

The PC CD-ROM Version 2. Discworld: The Directors Cut.

### notes

```
Doesn't require any patches, this version shipped with all bugs fixed.

Version information: https://www.us.lspace.org/games/discworld/faq.html#part2.3
```

### content

```
game:
  game_id: tinsel:dw
  path: $GAMEDIR
installer:
- insert-disc:
    requires: ../DISCWORLD/dwu.exe
- execute:
    command: cp "$DISC/../DISCWORLD/discwld/{*.idx,*.scn, *.smp,*.txt,midi.dat,index,../drivers/sample.ad,../drivers/sample.opl}"
      "$GAMEDIR/"
scummvm:
  fullscreen: true

```

