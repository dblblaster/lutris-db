### url

https://lutris.net/api/installers/atomic-bomberman-cd

### game_slug

atomic-bomberman

### runner

wine

### version

CD

### description



### notes

```
Do not alt-tab while playing, it breaks graphics.
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
  exe: $GAMEDIR/$gamepath/bm95.exe
  prefix: $GAMEDIR
installer:
- insert-disc:
    requires: ../BOMBRMAN/sfadmo95.exe
- task:
    arch: win32
    install_gecko: false
    install_mono: false
    name: create_prefix
    prefix: $GAMEDIR
- execute:
    args: -p $GAMEDIR/$gamepath
    file: mkdir
- execute:
    command: cp -r "$DISC/../BOMBRMAN"/{*.rmp,bm95.*,*.pal,*.bm,*.fon,*.txt,makecfg.exe,data,tools,winereg}
      "$GAMEDIR/$gamepath/"
- execute:
    command: echo -n -e "\x81\xfb\xbf\x33" > "$GAMEDIR/$gamepath/levels.dat"
- write_file:
    content: '; created by d:\makecfg.exe

      hdhome=C:\INTRPLAY\BOMBRMAN

      cdhome=d:\

      ; debug=3debug.log

      soundonoff=1

      netonoff=1

      '
    file: $GAMEDIR/$gamepath/cfg.ini
variables:
  gamepath: drive_c/INTRPLAY/BOMBRMAN

```

