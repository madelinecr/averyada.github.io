---
title: Custom Environments for Vagrant
layout: post
date: '2014-06-13 20:49:21'
---

I've recently been trying out [Vagrant][vagrant] for a couple different tasks in
my development workflow, and I've found it to be truly wonderful in certain
roles. For those that haven't heard of it, Vagrant is basically a wrapper that
makes managing development virtual machines much less painful. I'm using it with
VirtualBox, but it also supports software such as VMWare and server environments
including Amazon EC2.

However, this isn't a "Getting Started with Vagrant 101" blog post. The main
documentation is a great resource and it's very easy to get things up and
running. What I found a little bit harder was figuring out how to fit Vagrant
into my workflow and feel comfortable using it. I wanted to be able to step
between my running Vagrant box and my local development environment and barely
be able to notice, and this is something that took a little more tinkering to
get just right.

I won't go into too much depth trying to sell you on all the reasons you might
want to use Vagrant, but I think it's a good idea to mention some major
motivations. First, If you use Vagrant, you can keep your development server
configured exactly the same as production. Second, you can wipe your entire
development setup at a moments notice, and get a clean copy back in about the
time it takes to get coffee. No more "weird, works on my machine", and no more
worrying you might mangle your local development environment and break other
project setups.

Your main interaction with Vagrant is through your project's Vagrantfile. The
standard [documentation][docs] has you create one for your new project, shows
how you'll select a "box" from the [Vagrant Cloud][vcloud] (and even share your
own, if you're inclined to) and then tweak that base configuration to get the
environment you need. Additional configuration is accomplished by providing
provisioning shell scripts, which can be ran either as an elevated user or the
developer account in the VM. Note this is far from the only way to provision
your VM, and Vagrant supports more robust solutions such as [Chef][chef] and
[Puppet][puppet].

Other configuration options are exposed directly in the Vagrantfile, which is
really just a Ruby file. These options let you control Vagrant itself, adding
things like port forwarding, SSH agent forwarding and folder syncing.

If you want to dig into the actual meat of how the above pieces fit together, I
highly recommend following along with the [docs][docs] before continuing here.

After I finished setting up my first VM, my first two thoughts were "This is so
cool!" and "This feels so *weird*". Jumping into my VM with `vagrant ssh` was
really convenient, but it didn't feel quite like home. It didn't feel like a
place I could be quite productive. Suddenly I had to keep track of whether I was
in the VM or on my local machine, whether I could fiddle with Rake tasks or run
git commands instead.

I wanted to improve this experience. It took some digging to find some of the
other configuration options that Vagrant offers. You can actually create a
`vagrant.d` folder in your home directory to add extra provisioning instructions
that are user global. You can see how I've set up my directory [here][vagrantd].

It should be very familiar compared to the per-project setup you likely have
already performed. Drop a `Vagrantfile` in here and add some config settings and
you'll be able to modify the behavior of every VM you provision as your user.
Pretty cool. [Mine][vagrantf] just has three lines. I turn on ssh agent
forwarding to make sure I can take advantage of it everywhere without explicitly
turning it on for each project, and I call two shell scripts. One runs
privileged, while the other does not.

The two scripts I added are [`base_pkg`][basepkg] and [`dotfiles`][dotfiles].
The first makes sure the apt-get mirrors are up to date and installs tools I
wouldn't feel at home without (git, vim, zsh). Then the second clones my entire
dotfiles repo and runs the [`bootstrap`][bootstrap] script in the root of it. I
found this was the most insulated way to get my environment customizations into
my VMs, but some may find it a tad hacky. It also requires a manual `git pull`
if I need to pull down any dotfile changes.

However, this lets me basically run `vagrant ssh` and live completely inside my
development VM while editing files from my real machine. Combining SSH
forwarding with my dotfiles and pre-installed git, it's a seamless jump between
the two. I haven't ran into any real complications with this setup yet, and in
fact it's been working quite well for me.

This is my first step into the world of development with Vagrant, and I've only
been at it for a few weeks. There might be much nicer ways to interact with my
boxes that I haven't yet discovered, and I'm sure things could be improved. If
you have any suggestions or want to share how you use Vagrant, feel free to
reach out to me on [twitter][twitter]. I'll be likely to mention you here,
especially if you know of a better way of approaching this problem. In the
meantime, I hope this helps some people feel more comfortable using Vagrant
while they develop.

[vagrant]:   https://www.vagrantup.com/
[docs]:      https://docs.vagrantup.com/v2/getting-started/index.html
[vcloud]:    https://www.vagrantcloud.com/
[chef]:      https://www.getchef.com/chef/
[puppet]:    https://puppetlabs.com/puppet/puppet-enterprise/
[vagrantd]:  https://github.com/pacebl/dotfiles/tree/master/config/vagrant.d
[vagrantf]:  https://github.com/pacebl/dotfiles/tree/master/config/vagrant.d/Vagrantfile
[basepkg]:   https://github.com/pacebl/dotfiles/blob/master/config/vagrant.d/base_pkg.sh
[dotfiles]:  https://github.com/pacebl/dotfiles/blob/master/config/vagrant.d/dotfiles.sh
[bootstrap]: https://github.com/pacebl/dotfiles/blob/master/bootstrap.sh
[twitter]:   https://twitter.com/bl_pace
