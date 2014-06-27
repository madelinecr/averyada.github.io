---
layout: post
title: Needs and Todos
date: '2014-06-26 20:40:19'
---

Every project is going to start accumulating a list of things that would be nice
to have, or that you just *need* to get around to, but not right at this moment.
There are all sorts of tools you can use to track these things, from [Github
Issues][ghi] to [Tomboy][tb] all the way down to the lowly `todo.txt` file.

I'll admit that most of my coding this summer has been hacking on side projects
and small experiments, and I've found that even [Trello][trell] can be a bit too
heavy for these kinds of projects.

So, I'm using the digital equivalent of some sticks and tinder to manage the
short-term wants for my different projects. This doesn't scale if you have more
than one person working on a project, but for small experiments it works great.
I've got `todo.txt` ignored globally in my `~/.gitignore` file, and I've written
two little shell functions to automate working with the files.

First, I started by writing the function `todo`:

{% highlight bash %}
function todo () {
  echo "Searching for #TODOs..."
  grep -R "TODO" .
  if [ -e "todo.txt" ]; then
    echo "\033[32mFound todo.txt:\033[0m"
    while read item; do
      echo " * $item"
    done < todo.txt
  fi
}
{% endhighlight %}

It's a really simple function, which does just two things. First, it calls grep
with the recursive flag to search for `#TODO`s that might be hiding anywhere in
the current directory. Secondly, it checks for the presence of a `todo.txt` file
and, if it exists, it prints it out with some pretty formatting.  The output
looks like so (color codes have been stripped):

    Found todo.txt:
     * add robots.txt
     * Update twitter badge to point to pace_bl account
     * Projects page needs love
     * About page needs to be built

As a complementary piece to this todo function, I wrote another function called
"needs". It seemed like the most natural language to use, and it lets me type
"needs some more work on index page":

{% highlight bash %}
function needs () {
  if [ -n "$1" ] && [ -f "todo.txt" ]; then
    echo "Appending to todo.txt: $@"
    echo "$@" >> todo.txt
  fi
}
{% endhighlight %}

It just concatenates and appends the todo item to `todo.txt`, if it exists. If
it doesn't exist it quietly exits without doing anything.

I definitely know I'll outgrow this solution at some point, but for now it's
working very well. I could see myself writing another function, or probably a
ruby script, to handle switching my `todo.txt` files over to Github issues or
Trello board items. Even then, I'll probably keep using this solution for
personal projects and let them grow organically as the need arises.

**A Quick Update**

I received some feedback from a kind developer, [Jan Andersen][jan], in the
[Programming][prog] community on Google+. Jan [pointed out][suggestion] that I
didn't need to parse `todo.txt` line by line with bash. I could do the heavy
lifting of formatting each output line by simply invoking `sed` instead.

[ghi]: https://github.com/blog/831-issues-2-0-the-next-generation
[tb]: https://wiki.gnome.org/Apps/Tomboy/
[trell]: https://www.trello.com/
[prog]: https://plus.google.com/communities/109728488971985783565
[jan]: https://plus.google.com/+JanBruunAndersen/posts
[suggestion]: https://plus.google.com/109182425131492855421/posts/LtJARbuuuqx
