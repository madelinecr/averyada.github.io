---
title: Automating Rtorrent - A Seedbox Guide
layout: post
---
Intermediate Torrenting: Running a Seedbox

A seedbox is a nice step up from a normal torrent client if you've decided you
want to get more serious about contributing back to your swarms. I personally
run an rtorrent instance on my home Debian server which I've automated to a fair
degree, which lets me seed files 24/7. I use this mostly for linux
distributions, such as the [ArchLinux ISO][archiso], so that I can help
contribute to the health of these open source projects.

I see a lot of people set up home services like this in a rather haphazard
fashion, running a daemonized process as their administrative user and giving it
free reign over their home directory. Isolating processes to their own user is a
good security practice, it can help you keep a tidier box and lower your
cognitive strain when working with a specific service. Personally, I also find
it easier to keep track of everything in one location.

I'm assuming you're running some variant of Debian on your server. The general
setup principles are the same no matter the flavor of linux, so adjust as
necessary based on your favorite package manager. To start out, we'll install
some software and add a new user:

    sudo aptitude install rtorrent screen
    sudo useradd -m rtorrent

This creates a new user named rtorrent, with a default home directory.  Note
that I didn't pass the `-p` flag, leaving this account without a password. This
was intentional, because this account shouldn't ever be logged in to like a
normal user. Having no password ensures that the rtorrent user can't be logged
in directly from a TTY. We'll be setting things up initially with `su`, but we
can add an ssh key for easy maintenance and monitoring. 

Switch to the new user with:

    sudo su rtorrent
    
This is a bit of a workaround but it'll do for the initial configuration. Change
to this user's home directory with `cd`, open the file `.rtorrent.rc` in your
favorite editor, and add the following:

    download_rate = 0
    upload_rate = 0

    directory = /home/rtorrent/downloads
    session = /home/rtorrent/.rtorrent/session

    port_range = 49152-65535
    port_random = yes

    schedule =
    watch_directory,5,5,load_start=/home/rtorrent/torrents/*.torrent
    schedule = untied_directory,5,5,stop_untied=
    schedule = tied_directory,5,5,start_tied=

    system.method.set_key = event.download.finished,link_complete,"execute=cp,-r,$d.get_base_path=,/home/rtorrent/finished"

The first 6 configuration options are rather self explanatory. The `schedule`
lines respectively set up where rtorrent should watch for files, that it should
start those torrents when they are created, and stop them when they are deleted.
Your session folder is where rtorrent stores its internal database that allows
it to keep track of torrents persistently. The very last line sets up rtorrent
to copy the finished files to a different directory. This specific option lets
me know when torrents have finished and lets me copy them to archival media
before clearing the temporary folder.

So, now we need to create the necessary folders in the home directory.  We can
do that with:

    mkdir -p downloads torrents finished .rtorrent/session

We also need to tweak a few settings so that rtorrent will work from the normal
user account you logged in with. Set the `finished` and `torrents` folders group
sticky with:

    chmod g+s finished torrents

Set open group permissions with:

    chmod g+rwx finished torrents

This sets both folders as group writable, and the sticky permission ensures that
files created within this folder inherit the same group. 

Having rtorrent start as the proper user on boot would be really nice, so we'll
create a new file called `start_rtorrent.sh`. Add the following:

    #!/bin/bash
    screen -d -m rtorrent

Add executable permissions:

    chmod +x start_rtorrent.sh

This script starts screen, executes the command `rtorrent` and immediately
detaches from the session. We still need to add this script to our crontab. To
ensure our newly created script is called on system boot, edit rtorrent's
crontab with `crontab -e` and add:

    @reboot /home/rtorrent/start_rtorrent.sh

Next, edit the `.bashrc` file and add `umask 0002`. This overrides the rtorrent
user's default umask of 0022, which means new files created by the rtorrent user
will have the permissions 775, or rwxrwxr-x. We're all done, take the
opportunity (optionally) add your public key to `~/.ssh/authorized_keys` and
`exit` the session. Then, just make sure your normal user is in the rtorrent
group with:

    sudo usermod -Ga rtorrent username

Now, just create symlinks pointing to `~rtorrent/torrents` and
`~rtorrent/finished` wherever you'd like in your home directory. Drop your
torrents in the `torrents` folder, and wait for the finished download to appear
in `finished`. You can safely delete these downloads and they'll still be
seeding, living in ~rtorrent/downloads.  Personally, I access this server over
NFS on my home LAN, but you could easily scp torrents or use any other mechanism
you'd prefer to get them on the machine. 

[archiso]:https://www.archlinux.org/download/
[PKA]:https://hkn.eecs.berkeley.edu/~dhsu/ssh_public_key_howto.html
