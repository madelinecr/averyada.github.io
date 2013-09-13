---
date: 2012-03-13 23:43:24+00:00
layout: post
title: Streamlining Gem Projects with Jeweler
---

I wanted to take a moment to share the slick features Jeweler has, and mention
its tight integration with Github. Installing jeweler and setting up your Github
credentials is simple.

    $ gem install jeweler
    $ git config --global github.user myUsername
    $ git config --global github.token myAPIToken

After it's set up, invoke jeweler with the following arguments to create a new
project. Here, I'm setting it up with rspec and cucumber for testing and having
a github repository automatically created.

    $ jeweler --rspec --cucumber --summary "My Awesome Project" --create-repo myawesomeproject
    create .gitignore
    create Rakefile
    create Gemfile
    create LICENSE.txt
    create README.rdoc
    create .document
    create lib
    create lib/myawesomeproject.rb
    create spec
    create spec/spec_helper.rb
    create spec/myawesomeproject_spec.rb
    create .rspec
    create features
    create features/myawesomeproject.feature
    create features/support
    create features/support/env.rb
    create features/step_definitions
    create features/step_definitions/myawesomeproject_steps.rb
    Jeweler has prepared your gem in ./myawesomeproject
    Jeweler has pushed your repo to http://github.com/sensae/myawesomeproject`

You can optionally enable your project in the Travis CI dashboard as well to get
continuous integration testing and email notifications as to your test suite's
status. All this together makes it almost effortless to create new ruby projects
and scripts. Couple this with Thor for easy command line arguments, and you've
got a recipe for making awesome shell scripts at a whim.
