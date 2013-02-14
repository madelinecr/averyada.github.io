---
title: A Primer on Surveillance Systems
layout: post
---

<div class="inline-image">
  <a href="http://www.flickr.com/photos/92260580@N04/8469741533/"
  title="Surveillance Camera by Lontran, on Flickr"><img
  src="http://farm9.staticflickr.com/8371/8469741533_9cd92589c3.jpg" width="500"
  height="334" alt="Surveillance Camera"></a>
  <footer>Credit:
    <a href="http://pixabay.com/en/surveillance-camera-camera-control-23037/">
      TilenHrovatic
    </a>
  </footer>
</div>

A few months ago I had the misfortune of experiencing an invasive burglary. I
was very lucky that I only lost a 2008 era iPod and $100. It was immediately
pretty clear that they were specifically targeting very light items, as they
passed over a Macbook Pro and a collection of camera lenses. In actuality, the
most distressing part of the experience was coming home to the contents of my
cigar humidor upended in the middle of the floor.

Unfortunately, this hasn't been the first time this house has been burgled, but
it has been the first time it's happened since I moved in. From what I've heard
from my roommates, after every incident the external security of the house has
been improved, but they keep managing to find the next weak spots. They're
annoyingly persistent. Mulling over this problem, I started to think about
access elevation, and treating my home security in the same way I would digital
security - in layers.

I started by prioritizing the rooms of my house based on their security
requirements. My bedroom contains my workstation and home electronics lab, and
my two roommates keep their valuables in their room as well. These rooms need to
be the most secure. The rest of the house is furnished, but doesn't hold many
expensive items. Thus, the central hallway connecting our rooms makes for a
great buffer between the 'high' and 'low' security sections of the house. If
burglars are going to get in, I'd at least like to see who it is, so I decided
to put up some security cameras. Before I talk about the specifics of my
security system, lets talk a little bit about how CCTV works in general.

The term CCTV is actually a bit confusing. It traditionally stands for Closed
Circuit Television, and that's how a large number of security setups operate.
It's the classic CCTV configuration. A video signal is sent along a coaxial BNC
terminated cable to a central system which interprets the video signals,
digitizes and stores it. There are a couple different configurations available
to consumers, from all in one DVR devices to add-on cards for standard PCs.
You're limited by the number of inputs on this input unit, with a common number
being four or eight. A four camera setup with a DVR set top box will set you
back a little over $500. This is a centralized security system.

These systems can be quite involved physically to get up and running, as you
need to run both power and coaxial lines to every camera you want to install.
They can also be more expensive and have a single point of failure. However,
these systems are still relatively popular and you can purchase one from any
number of retailers.

With the proliferation of wireless devices around the home, a new type of
security camera has emerged - the wireless IP camera. If you have a spare
computer to use as a DVR, these devices are much cheaper in terms of initial
investment and offer some cool perks.

<div class="inline-image">
  <a href="http://www.flickr.com/photos/exacq/4467447316/" title="ISC West 2010 9
  by exacq, on Flickr"><img
  src="http://farm5.staticflickr.com/4037/4467447316_27fb6a0680.jpg" width="500"
  height="375" alt="ISC West 2010 9"></a>
  <footer>Credit:
    <a href="http://www.flickr.com/photos/exacq/4467447316/">
      exacq
    </a>
  </footer>
</div>

An IP Camera based system is considered a decentralized security system. These
units are smart little devices, and $80 should get you a Wifi enabled model with
up to 300 degrees of panning range. They do their own digitizing, and many of
them export their footage to a moving JPEG (MJPEG) served over HTTP. After
configuring your IP camera to connect to your wireless network, you only need to
run power to them.

You can log in directly to the camera at its local network address to change its
internal settings or pan and tilt it around. This distributes responsibility off
of the central server, leaving it to focus on just motion detection and storage.
Given the networked nature of the cameras, you can run as many as your server
can handle processing. Also, in the case of a server outage, you can still view
individual camera feeds, something that isn't possible with a coaxial system.

The downside to an IP camera system is that there's a lot more networking
involved. That isn't to say coaxial systems are simpler, because they bring
their own complexities, but IP cameras may not be the best choice if you just
want to purchase a full solution you can physically mount, plug in and flip on.

As for my specific setup, I put a good amount of thought into what would be
easiest to incorporate into my existing home network. I already run a Debian
server at home, which puts Linux support high on my list of requirements - I
need this same computer to monitor and record from my new cameras. I found
[ZoneMinder][1], which is a great open source project for running a CCTV system
and was pretty easy to install. I looked through their hardware compatibility
list and found Foscam makes an affordable wireless pan/tilt security camera, the
[Foscam FI8918W][2]. I purchased two of them from Amazon and got to work
mounting them on the ceiling. Strategically placed, the combined coverage of
both their infrared LEDs completely light up the hallway on the feeds.

<div class="inline-image">
  <a href="http://www.flickr.com/photos/92260580@N04/8466952501/"
  title="camfeed-1 by Lontran, on Flickr"><img
  src="http://farm9.staticflickr.com/8100/8466952501_b36107e8f6.jpg" width="500"
  height="375" alt="camfeed-1"></a>
</div>

After connecting the cameras to my wireless I issued two static DHCP leases
using their MAC addresses. I use [DD-WRT][3] on my router at home, which made it
pretty easy. Zoneminder needs an install of PHP and MySQL because it's a full
fledged web application, but they have pretty good instructions over at the
[wiki][4].

Configuring Zoneminder takes a few more steps. First is adding the cameras by
the static IPs I leased in the router, and setting up the storage path. After
that, there are a couple ways Zoneminder can record. If you need 24/7 recording,
you can select "record" for each device. I wanted to record when movement is
detected, which is the "modect" option. There are a lot of ways Zoneminder can
work, and if you're curious you should read the [tutorial][5]. This
configuration has given me a very hands off system. It automatically logs events
based on movement, and I can log in and review them on a timeline.

Of course, a CCTV setup definitely isn't a silver bullet, and this is only one
piece of the puzzle when talking about a more secure home. However, a system
like this is a good way to start down the path of home surveillance and possibly
home automation. It's definitely given me some peace of mind. I've purposefully
written this post as an overview, because there's really great documentation
over at the Zoneminder site if you want to get something similar up and running.

[1]: http://www.zoneminder.com/
[2]: http://amzn.to/12hCt0s 
[3]: http://www.dd-wrt.com/
[4]: http://www.zoneminder.com/wiki/index.php/Main_Documentation
[5]: http://www.zoneminder.com/wiki/index.php/Main_Documentation#Tutorial
