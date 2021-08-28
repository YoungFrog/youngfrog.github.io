---
layout: post
title: "Flash new Libreboot ROM to my T400"
categories: jepensetouthaut informatique
# featured-image: 
# featured-source: 
summary: ""
---
I'm about to update my libreboot version.

I cloned https://notabug.org/libreboot/lbmk
and followed https://libreboot.org/docs/build/ (up to the "using GNU Make" section)

Then I follow
https://libreboot.org/docs/install/#install-via-host-cpu-internal-flashing

Some information gathered :

```
$ sudo flashrom -p internal
[sudo] password for user: 
flashrom v0.9.9-rc1-r1942 on Linux 4.4.0-210-lowlatency (x86_64)
flashrom is free software, get the source code at https://flashrom.org

Calibrating delay loop... OK.
coreboot table found at 0x7fad6000.
Found chipset "Intel ICH9M-E".
Enabling flash write... OK.
Found Macronix flash chip "MX25L6405" (8192 kB, SPI) mapped at physical address 0x00000000ff800000.
Found Macronix flash chip "MX25L6405D" (8192 kB, SPI) mapped at physical address 0x00000000ff800000.
Found Macronix flash chip "MX25L6406E/MX25L6408E" (8192 kB, SPI) mapped at physical address 0x00000000ff800000.
Found Macronix flash chip "MX25L6436E/MX25L6445E/MX25L6465E/MX25L6473E" (8192 kB, SPI) mapped at physical address 0x00000000ff800000.
Multiple flash chip definitions match the detected chip(s): "MX25L6405", "MX25L6405D", "MX25L6406E/MX25L6408E", "MX25L6436E/MX25L6445E/MX25L6465E/MX25L6473E"
Please specify which chip definition to use with the -c <chipname> option.
```

see also file atreus:thinkpad-beforeflashing.zip (not public)

