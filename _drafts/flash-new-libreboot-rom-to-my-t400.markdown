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

```
$ grep 'at EC' /proc/asound/cards
                      ThinkPad Console Audio Control at EC reg 0x30, fw 7VHT12WW-3.7
```

see also file atreus:thinkpad-beforeflashing.zip (not public)

```
$ sudo flashrom -p internal:laptop=force_I_want_a_brick,boardmismatch=force --ifd -i bios -w grub_t400_8mb_libgfxinit_corebootfb_frazerty.rom 
flashrom v1.2-472-g822cc7e on Linux 4.4.0-210-lowlatency (x86_64)
flashrom is free software, get the source code at https://flashrom.org

Using clock_gettime for delay loops (clk_id: 1, resolution: 1ns).
coreboot table found at 0x7fad6000.
Found chipset "Intel ICH9M-E".
Enabling flash write... OK.
Found Macronix flash chip "MX25L6405" (8192 kB, SPI) mapped at physical address 0x00000000ff800000.
Found Macronix flash chip "MX25L6405D" (8192 kB, SPI) mapped at physical address 0x00000000ff800000.
Found Macronix flash chip "MX25L6406E/MX25L6408E" (8192 kB, SPI) mapped at physical address 0x00000000ff800000.
Found Macronix flash chip "MX25L6436E/MX25L6445E/MX25L6465E/MX25L6473E/MX25L6473F" (8192 kB, SPI) mapped at physical address 0x00000000ff800000.
Multiple flash chip definitions match the detected chip(s): "MX25L6405", "MX25L6405D", "MX25L6406E/MX25L6408E", "MX25L6436E/MX25L6445E/MX25L6465E/MX25L6473E/MX25L6473F"
Please specify which chip definition to use with the -c <chipname> option.
user@user-ThinkPad-T400:~/lbmk/bin/t400_8mb$ sudo flashrom -p internal:laptop=force_I_want_a_brick,boardmismatch=force --ifd -i bios -w grub_t400_8mb_libgfxinit_corebootfb_frazerty.rom  -c MX25L6405
flashrom v1.2-472-g822cc7e on Linux 4.4.0-210-lowlatency (x86_64)
flashrom is free software, get the source code at https://flashrom.org

Using clock_gettime for delay loops (clk_id: 1, resolution: 1ns).
coreboot table found at 0x7fad6000.
Found chipset "Intel ICH9M-E".
Enabling flash write... OK.
Found Macronix flash chip "MX25L6405" (8192 kB, SPI) mapped at physical address 0x00000000ff800000.
Reading ich descriptor... done.
Using region: "bios".
Reading old flash chip contents... done.
Erasing and writing flash chip... FAILED at 0x00001000! Expected=0xff, Found=0x00, failed byte count from 0x00000000-0x0000ffff: 0x69b8
ERASE FAILED!
Reading current flash chip contents... done. Looking for another erase function.
Erase/write done.
Verifying flash... FAILED at 0x00000000! Expected=0x5a, Found=0xff, failed byte count from 0x00000000-0x007fffff: 0x66
Your flash chip is in an unknown state.
Get help on IRC (see https://www.flashrom.org/Contact) or mail
flashrom@flashrom.org with the subject "FAILED: <your board name>"!-------------------------------------------------------------------------------
DO NOT REBOOT OR POWEROFF!
user@user-ThinkPad-T400:~/lbmk/bin/t400_8mb$ sudo flashrom -p internal:laptop=force_I_want_a_brick,boardmismatch=force --ifd -i bios -w ~/dump-MX25L64  -c MX25L6405
dump-MX25L6405D.img                                   dump-MX25L6406E-MX25L6408E.img
dump-MX25L6405.img                                    dump-MX25L6436E-MX25L6445E-MX25L6465E-MX25L6473E.img
user@user-ThinkPad-T400:~/lbmk/bin/t400_8mb$ sudo flashrom -p internal:laptop=force_I_want_a_brick,boardmismatch=force --ifd -i bios -w ~/dump-MX25L6405D.img  -c MX25L6405
flashrom v1.2-472-g822cc7e on Linux 4.4.0-210-lowlatency (x86_64)
flashrom is free software, get the source code at https://flashrom.org

Using clock_gettime for delay loops (clk_id: 1, resolution: 1ns).
coreboot table found at 0x7fad6000.
Found chipset "Intel ICH9M-E".
Enabling flash write... OK.
Found Macronix flash chip "MX25L6405" (8192 kB, SPI) mapped at physical address 0x00000000ff800000.
Reading ich descriptor... done.
Couldn't parse the descriptor!
Segmentation fault
user@user-ThinkPad-T400:~/lbmk/bin/t400_8mb$ 
```
