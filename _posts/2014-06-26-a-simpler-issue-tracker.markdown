---
layout: post
title: A Simpler Issue Tracker
date: '2014-06-26 20:40:19'
---

Every project is going to start accumulating a list of things that would be nice
to have, or that you just *need* to get around to, but not right at this moment.
There are all sorts of tools you can use to track these things, from [Github
Issues][ghi] to [Tomboy][tb] all the way down to the lowly `todo.txt` file.
That's exactly what we're here to talk about.

I'll admit that most of my coding this summer has been hacking on side projects
and small experiments, and I've found that even [Trello][trell] can be a bit too
heavy for these kinds of projects.

So, I'm using the digital equivalent of some sticks and tinder to manage the
short-term wants lists for my different projects: shell functions! This doesn't
scale if you have more than one person working on a project, but for small
experiments it works great.  I've written a number of small scripts to automate
working with my `todo.txt` file, which I stick in the root folders of my
different projects.

One important thing to note, I've made sure to ignore `todo.txt` globally in my
`~/.gitignore` file. You'll need to also make sure you configure git to use this
global ignore file by running:

```
git config --global core.excludesfile '~/.gitignore'
```.

I started by writing the function `todo`. It's a really simple function,
which does just two things. First, it calls grep with the recursive flag to
search for `TODO`s that might be hiding anywhere in the current directory.
Secondly, it checks for the presence of a `todo.txt` file and, if it exists, it
prints it out with some pretty formatting.

{% highlight bash %}
function todo () {
  echo "Searching for TODOs..."
  grep -R "TODO" .
  if [ -e "todo.txt" ]; then
    echo "\033[32mFound todo.txt:\033[0m"
    while read item; do
      echo " * $item"
    done < todo.txt
  fi
}
{% endhighlight %}

The output of `todo` looks like this (color codes have been stripped):

    Found todo.txt:
     * add robots.txt
     * Update twitter badge to point to pace_bl account
     * Projects page needs love
     * About page needs to be built

As a complementary piece to this todo function, I wrote another function called
"needs". It seemed like the most natural language to use, and it lets me type
"needs some more work on index page" (who doesn't love vague tickets?).

{% highlight bash %}
function needs () {
  if [ ! -e "todo.txt" ]; then
    touch todo.txt
  fi
  if [ -n "$1" ] && [ -f "todo.txt" ]; then
    echo "Appending to todo.txt: $@"
    echo "$@" >> todo.txt
  fi
}
{% endhighlight %}

It just concatenates and appends the todo item to `todo.txt`, if it exists. If
it doesn't exist naturally it creates the file and proceeds.

I definitely know I'll outgrow this solution at some point, but for now it's
working very well. I could see myself writing another function, or probably a
ruby script, to handle switching my `todo.txt` files over to Github issues or
Trello board items. Even then, I'll probably keep using this solution for
personal projects and let them grow organically as the need arises.

[//]: #TODO (Instead of using strong tags, these should really be headers)
[//]: #TODO (The CSS needs to be updated first to make it visually agreeable)

**A Quick Update**

I received some feedback from a kind developer, [Jan Andersen][jan], in the
[Programming][prog] community on Google+. Jan [pointed out][suggestion] that I
didn't need to parse `todo.txt` line by line with bash. I could do the heavy
lifting of formatting each output line by simply invoking `sed` instead.

**Update #2**

I've found that this system worked even better for me with some small tweaking
and wanted to share the revisions it's gone through. I'm leaving my original
solution up above because I think a lot of this is personal preference.

I found the todo function a bit too far reaching, so I shrank its scope. I also
implemented the [sed suggestion][suggestion] from Jan. Now it simply reads
`todo.txt` if it exists, mostly like before.

{% highlight bash %}
function todo () {
  if [ -e "todo.txt" ]; then
    echo "\033[32mFound todo.txt:\033[0m"
    sed -n 's/^/ \* /p' todo.txt
  fi
}
{% endhighlight %}

The grep functionality was useful and didn't move far. It's new home is over in
`greptodo`. Eagle-eyed readers will notice I'm also passing the `-I` option now,
which ignores binary files.

{% highlight bash %}
function greptodo () {
  grep -IR "#TODO" .
}
{% endhighlight %}

I also realized I wanted a quick way to browse through all these `todo.txt`
files I've been creating. I wrote `findtodo` for just that. It's just a one line
wrapper around find and sed. Find searches your current directory and below,
printing each todo file and its contents in an easy to read format.

{% highlight bash %}
function findtodo () {
  find . -name "todo.txt" -exec sh -c 'echo "\n{}"; sed -n "s/^/ \* /p" {}' \;
}
{% endhighlight %}

I find this function the most useful out of them all. If I `cd` to my directory
for open source/side projects and run it, I'll get a nice menu of all the
things I might want to work on. I've found it a lot easier to keep multiple
side projects going by working this way.

Instead of fumbling with "What do I work on right now?" I can just ask my
projects folder, glance through the contents and pick something that sounds fun.
I've actually found it a little too conducive to keeping me motivated, as the
urge to finish just one more task can be overwhelming. Obviously this is true no
matter what system is used, but what's important is making sure you do use
something. Doing this with even the tiniest of projects has definitely kept me
more organized and productive.

[ghi]: https://github.com/blog/831-issues-2-0-the-next-generation
[tb]: https://wiki.gnome.org/Apps/Tomboy/
[trell]: https://www.trello.com/
[prog]: https://plus.google.com/communities/109728488971985783565
[jan]: https://plus.google.com/+JanBruunAndersen/posts
[suggestion]: https://plus.google.com/109182425131492855421/posts/LtJARbuuuqx
