---
title: Issues with Jekyll and Markdown
---

I ran into a very odd issue with [Jekyll][jekyll] the last time I was writing a
blog post, and because the solution evaded me for quite awhile I thought I would
post a quick little writeup about it.

I started to write a new blog post in Markdown, and found that either the post
wouldn't be generated or jekyll would simply die depending on which flags it was
invoked with. When it died it would throw an error like this.

    psych.rb:203:in `parse': mapping values are not allowed in this context

Well, that's an odd error, isn't it? What broke Jekyll? It took some Googling
and digging through the code outlined in the Jekyll stack trace before I
realized the problem. I had named my new blog post with a colon in the title,
and Ruby was trying to parse it through its YAML interpreter, [Psych][psych].
I'm still not sure why Psych was being invoked here, but properly encoding the
colon in the title with `&#58;` was an easy fix.

[jekyll]: http://www.jekyllrb.com/
[psych]: https://github.com/tenderlove/psych
