---
layout: post
title: "Org mode settings for the exporter"
categories: informatique
# featured-image: 
# featured-source: 
summary: "À quoi"
---
I recently tried to use Org mode for exporting. And I actually dislike it.

In this specific instance, I want to cross-reference a captioned image.

It turns out just setting #+NAME: on the image is not enough:

#+NAME: mylabel
#+CAPTION: look at this
[[/path/to/image]]

because Org mode now knows better than us, and introduced `org-latex-prefer-user-labels` which defaults to nil. Only if non-nil, it will obey the NAME option.

This is not only annoying because this is a backwards-incompatible change, but also because it's yet another thing to think about when you distribute your Org file. The best thing I can think of is to use a local variable
