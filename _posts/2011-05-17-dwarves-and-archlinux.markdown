---
date: 2011-05-17 01:11:28+00:00
layout: post
title: Dwarves and (Arch)Linux
categories:
- Software
tags:
- archlinux
- gaming
---

I'm a pretty avid linux user, and I try to minimize the time I spend in Windows,
even for a game as [fun ](http://df.magmawiki.com/index.php/DF2010:Losing)as
Dwarf Fortress. I was very happy to hear that there are linux packages available
for the game now, as that wasn't always the case. If anyone reading this hasn't
  yet played Dwarf Fortress, I implore you to grab the game from their [main
  site](http://www.bay12games.com/dwarves/) and [follow
  along](http://df.magmawiki.com/index.php/40d:Your_first_fortress).

Unfortunately, the in game GUI for managing dwarf tasks is, to put it softly,
abysmal once you've got a decent sized fortress. That's where Dwarf Therapist
comes in, which is a great third party dwarf management tool. If you're on a
debian-based distro, they offer [debian
packages](http://code.google.com/p/dwarftherapist/wiki/LinuxVersion) which makes
installation trivial.

However, ArchLinux users aren't so fortunate in terms of an easy installation,
as Dwarf Therapist must be compiled. However, this is actually a benefit, as the
current version of DT also has a very annoying bug in which custom professions
do not work. What follows is a guide to compile DT for ArchLinux, and in the
  process apply a patch during the build that fixes the custom profession bug.

An [Arch User Repository (AUR)](https://wiki.archlinux.org/index.php/AUR)
package for Dwarf Therapist exists, which makes compilation of the package very
simple. I'll go step by step for anyone who hasn't compiled a package using the
[Arch Build System
(ABS)](https://wiki.archlinux.org/index.php/Arch_Build_System) before, but if
you're not even sure what these things are, I strongly recommending reading the
two wiki pages I've linked. Follow the ABS guide if you don't have it already
installed on your system.

Navigate to your ABS tree, creating some extra folders for AUR packages.

    $ cd /var/abs
    $ mkdir -p local/aur && cd local/aur

The AUR package for Dwarf Therapist is located
[here](https://aur.archlinux.org/packages.php?ID=38062). Now we'll copy the link
location of the "Tarball" link on that page, pull it to our local system,
extract it and delete the archive.

    $ wget https://aur.archlinux.org/packages/dwarftherapist-hg/dwarftherapist-hg.tar.gz
    $ tar -xzvf dwarftherapist-hg.tar.gz
    $ rm dwarftherapist-hg.tar.gz
    $ cd dwarftherapist-hg

Currently there's an [open
issue](http://code.google.com/p/dwarftherapist/issues/detail?id=175) in the
ticket tracker for Dwarf Therapist. Download linux-nickname.hg and place it in
/var/abs/local/aur/dwarftherapist-hg/. Edit the PKGBUILD file, and locate line
40, which should read:

    hg checkout 9ac1306c2abd

Add these two lines directly after that line.

    hg unbundle ../../linux-nickname.hg
    hg update


All that's left then is to build the package and install it.

    $ makepkg -s
    sudo pacman -U dwarftherapist-hg-0.6.10-2-i686.pkg.tar.xz

If both steps succeeded, go ahead and try to run your freshly patched and
compiled copy of Dwarf Therapist.

    $ dwarftherapist &

If all has gone well, you should see dwarf fortress launch and probably complain
that you don't have an instance of Dwarf Fortress running. Success!
