---
date: 2011-06-21 00:09:11+00:00
layout: post
title: The Beauty of Rebasing
---

I've recently discovered the wonderful git tool known as rebase (before I had
just merged everything, making an awfully ugly commit history tree). Rebase is a
git command which detaches your feature branch from the last common ancestor
commit of another tree, and reapplies it at the head of the target tree. I'll
demonstrate with some images for more clarity.

<!--[![graph 1](http://bpace.info/wp-content/uploads/2011/06/1.png)](http://bpace.info/wp-content/uploads/2011/06/1.png)-->

I'm sure everybody has been in this situation, where a few commits have been
made on a feature branch parallel to a few commits being introduced to its
parent. This situation can be resolved by checking out master, and then merging
our feature branch. It would result in a source tree which looks like this.

<!--[![graph 2](http://bpace.info/wp-content/uploads/2011/06/2.png)](http://bpace.info/wp-content/uploads/2011/06/2.png)-->

However, if while on our feature branch we rebase master, it will detach our
feature branch and then re-apply it to the head of the master branch, resulting
in a tree that looks like this.

<!--[![graph 3](http://bpace.info/wp-content/uploads/2011/06/3.png)](http://bpace.info/wp-content/uploads/2011/06/3.png)-->

Afterwards, all that's needed is to check out master, merge the feature branch
into master (which results in a fast-forward instead of a full-on merge), and
push master out. I'd like to note that this technique is really meant for
local-only feature branches that aren't pushed out to a remote repository.
Rebasing modifies the history of your git repository and can cause very bad
things to happen if care isn't taken.

I'll end this post with some links to further reading on the topic of git
rebase, and how it's not always the best solution for a given problem. However,
in specific situations and when working with private small-lived feature
branches it's an extremely useful tool.

[http://darwinweb.net/articles/the-case-for-git-rebase](http://darwinweb.net/articles/the-case-for-git-rebase)

[http://changelog.complete.org/archives/586-rebase-considered-harmful](http://changelog.complete.org/archives/586-rebase-considered-harmful)
