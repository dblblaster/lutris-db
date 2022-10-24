### url

https://lutris.net/api/installers/another-world-cd-15th-anniversary-

### game_slug

another-world

### runner

wine

### version

CD 15th Anniversary Edition

### description



### notes

```

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
  arch: win64
  exe: $GAMEDIR/$gamepath/Another World.exe
  prefix: $GAMEDIR
installer:
- insert-disc:
    requires: ../Another World/AnotherWorld_full.exe
- task:
    arch: win64
    executable: $DISC/../Another World/AnotherWorld_full.exe
    name: wineexec
    prefix: $GAMEDIR
variables:
  gamepath: drive_c/Program Files (x86)/Another World
wine:
  Desktop: true

```

