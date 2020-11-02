---
layout: post
title: "Backup of an iPad Pro from a GNU/Linux system over USB"
categories: informatique
# featured-image: 
# featured-source: 
summary: "We have this dying iPad, in need of an emergency backup. I don't have a Mac OS or a Windows device avaiable, and I wanted to avoid the wine+iTunes combo as well as the iCloud solution. Enter `libimobiledevice`."
---

A few possibly interesting resources

<https://gist.github.com/samrocketman/70dff6ebb18004fc37dc5e33c259a0fc> : someone documented what he did. I didn't follow, but might be worth checking out
<https://hackmag.com/security/apple-forensic/> : also mentions talking to an Apple device from Linux
<https://github.com/hackappcom/iloot> : as they describe it : Using this CLI tool you can download backups of devices assigned to your AppleID

<https://code.google.com/archive/p/iphone-dataprotection/> : (warning: code.google is probably going down  at some point.) old and une maintained project.
<https://github.com/dinosec/iphone-dataprotection> : fork of the above, with some updates and hindsights.
<https://www.hack42labs.com/blog/2018/06/19/howto-decrypt-ios10-backups-with-iphone-dataprotection/> : some practical usage information of the above tools

# The idea

# The take away

# The full story

## The wrong ideas

The main problem is that the machine (iPad) is basically dying. Once it's shutdown, it might take anywhere from a few minutes to a few days to start it again. 

I assume it's a battery problem, but that's irrelevant to the problem at hand : *backup ALL the files* !

### iCloud
I did not want 

### wine+iTunes

### Over the rainbow^W wifi.

## The fine idea

### The problems

So after some googling
`ERROR: Could not connect to lockdownd, error code -3`

compiled everything (libplist, libusbsomething, libimobile)

`ERROR: Could not connect to lockdownd: SSL error (-5)`

unback with device conected :

dumps a whole lot of files (4.4 G, versus 4.6 for the backup dir), but then

`ERROR: Could not receive from mobilebackup2 (-4)`

found https://github.com/libimobiledevice/libimobiledevice/issues/853
which mentions using GnuTLS. Tried, didn't work better.

unback without device connected :
says "No device found" ':(

Even giving -u with the name of the backup directory (generated when creating the backup), doesn't work.


`$ idevicebackup2 list -u ac125a5d32adc71283b0d89fe65acd860a5a779d /media/user/Transcend/Backup\ 20200713\ IPAD\ PRO/
No device found with udid ac125a5d32adc71283b0d89fe65acd860a5a779d.
`

07-13 15:45 <nicolas17> idevicebackup2 doesn't know anything about the backup format, everything is controlled by the device                                  
07-13 18:33 <nicolas17> apps are *not* in the backup, only the list of apps and the data, when you restore the backup the app itself is downloaded from the a\
=>-13 18:41 <nicolas17> I think there are programs elsewhere that can do the "unback" process on your computer alone                                          

