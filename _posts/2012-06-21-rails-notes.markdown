---
date: 2012-06-21 19:48:08+00:00
layout: post
title: Rails Notes
---

Just a quick little post in case some people out there don't know about the note
keeping feature in Rails.

There's a rake task called "notes" that will search your codebase for any `#TODO`,
`#FIXME` or `#OPTIMIZE` annotations and print them in a pretty list, like so.


    $ rake notes
    app/controllers/submissions_controller.rb:
    * [ 38] [TODO] Write destroy action

    app/models/submission.rb:
    * [ 5] [TODO] Integrate with Amazon S3
