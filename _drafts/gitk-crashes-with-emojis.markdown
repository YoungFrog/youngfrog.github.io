---
layout: post
title: "Gitk crashes with emojis"
categories: informatique
# featured-image: 
# featured-source: 
summary: ""
---
I hda this kind of crash :

    $ gitk
    X Error of failed request:  BadLength (poly request too large or internal Xlib length error)
      Major opcode of failed request:  139 (RENDER)
      Minor opcode of failed request:  20 (RenderAddGlyphs)
      Serial number of failed request:  3132
      Current serial number in output stream:  3179


First tried installing fonts-noto as suggest on <https://github.com/LukeSmithxyz/voidrice/issues/284>
but crash remained

then followed
<https://unix.stackexchange.com/questions/629281/gitk-crashes-when-viewing-commit-containing-emoji-x-error-of-failed-request-ba>
and did `sudo apt remove --purge fonts-noto-color-emoji`

No more crashes, yay!
