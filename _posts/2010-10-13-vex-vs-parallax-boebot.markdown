---
date: 2010-10-13 22:01:31+00:00
layout: post
title: Vex vs Parallax Boebot
categories:
- Technology
tags:
- robotics
---

I recently posted a snapshot of my current Boebot build. I  wanted to take the
opportunity to write a longer post about my brief  experience with both the Vex
robotics system and Parallax's offerings,  most notably the Boebot.

My team had the opportunity in my robotics class to switch from the  Vex
platform to the Boebot platform, and we jumped at it. This  highlights the
general attitude that I and my team had regarding Vex.

The restriction of using EasyC for programming the Vex units proved  to be a
large stumbling block. As I said in an earlier blog post, I see  the utility of
providing an easier platform for programming, but it  becomes a headache for
competent programmers. Additionally, the only  true programming API for these
units is an open source project which  hasn't been maintained for years and
primarily runs on FreeBSD. The  nuances of other nix-based platforms causes
major problems in the proper  compilation of this library, and as such I was
only able to use it in a  FreeBSD virtual machine. This causes a large gap in
usable tools versus  target users, as EasyC is too watered down and the OpenVex
library I  would dare say is too complicated to easily set up and use for the
average programmer without a competent understanding of Unix systems. I  won't
be going into further depth about how I was required to configure  my
programming environment, because even operable it was clunky,  unwieldy and we
quickly moved on to the Boebot.

On the other hand, the Boebot provides unique challenges that I feel  more
accurately represents the difficulties of robotics. It utilizes the  Basic Stamp
2 micro-controller, and programming for this platform  involves writing in a
decently flexible Basic-style programming  language. Additionally, there is
virtually no API to speak of, for good  reason. The configuration of the boebot
is much more flexible because of  the hand wiring required, and programs for the
boebot are concerned  with toggling voltages on pins and communicating over
serial with other  modules. I feel that this allows for a much more broad skill
set to  develop versus learning on the Vex system. Instead of issuing a single
command to move a motor at a certain speed, such as on a Vex unit, a BS2
program would be required to send high voltage pulses at different  intervals to
control the speed and direction of the included continuous  rotation stepper
motors. Instead of hiding away the basic electronic  functionality of the robot,
this bare-bones approach allows the user to  control every functionality of
individual circuits, increasing  creativity and the fundamental understanding of
the basic principles and  pitfalls of robotics.

I know this post sounds like simply a plug for Parallax and their  Boebot, but I
feel that they're put together a superior product and I  feel this is apparent
in the usability and flexibility of each platform.  While on the Vex platform,
additional functionality can only be  obtained by purchasing more modules. While
this is true to some extent  on the Boebot platform, a simple trip to Radioshack
to purchase  additional electronic components is a viable option. To highlight a
specific difference in attitudes and platform openness, one only needs  to look
at the offerings for shaft encoders. On the Vex platform, shaft  encoders are
standalone units that must be purchased. While it is true  that Parallax sells
shaft encoder add ons for the Boebot, the wheels  included with the unit already
have slits for an encoder and all  documentation for the encoder units is freely
available in PDF and ZIP  formats. A cunning individual would be able to take
some wires, infrared  LEDs and receivers and rig up their own shaft encoder
solution.

In summary, the Boebot is a much more pleasant and flexible platform  to work
on, and I'm glad we had the opportunity to utilize it in place  of the Vex
system. As an additional plus, there are currently maintained  community
tokenizers (compilers) for the PBASIC syntax language that  the micro-controller
on the Boe-bot uses. The Vex EasyC IDE is only  available on Microsoft Windows,
and as I've mentioned the only community  compiler/API for the platform is a
stagnant library which only compiles  nicely on FreeBSD. I dare suggest this
also potentially highlights the  popularity of both platforms in the hobbyist
robotics community.
