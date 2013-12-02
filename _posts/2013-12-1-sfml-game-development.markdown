---
date: 2013-12-01
layout: post
title: SFML Game Development
---

Recently I was sent a review copy of [SFML Game Development][sfmlgamedev] by
[Packt Publishing][packt]. [SFML][sfml] stands for the "Simple and Fast
Multimedia Library", and is one of two major libraries used in 3D OpenGL
graphics programming. The competitor to [SFML][sfml] is [SDL][sdl], which is a C
library. Comparatively, SFML is written in C++. I'll cover an overview of the
book's contents and a quick review.

<div class="float-right">
  <a href="http://www.flickr.com/photos/22878074@N03/11166836076">
    <img src="http://farm6.staticflickr.com/5504/11166836076_ed97eec3f7_n.jpg"/>
  </a>
</div>

SFML is quite complex, and so is C++. This book assumes a fairly competent
programmer who is already familiar with most of the language constructs of C++.
It's recommended the reader understand variables, data types, functions,
classes, polymorphism, pointers and templates. If you don't, I wouldn't
recommend trying to learn C++ in parallel with SFML. It would be quite a
challenge. If you don't know C++ very well, I'd recommend [Absolute
C++][savitch]. On to the book!

[SFML Game Development][sfmlgamedev] starts off with a strong first chapter,
covering a basic graphical "Hello world". It covers user input using the more
modern events API, as opposed to the old polling API. It also covers in depth
frame independent movement and fixed time steps.

After explaining some of the basics of getting an SFML project up and running,
it jumps right into building a modern clone of [1942][1942]. It covers building
an asset pipeline, rendering scenes, getting player input, playing music,
multiplayer code, gameplay logic, and transitioning between states such as the
main menu, gameplay, and boss screens. It even finds some time to cover a basic
bloom shader in [GLSL][glsl].

At 280 pages long, this book is short but sweet. It walks you through a complete
project from start to finish, and gets you up and running with SFML. You'll be
writing your own real time graphics in no time. When I was learning SFML 1.5,
there weren't resources like this available. It was a much slower, more painful
process than it is now. If you're interested in high performance real time
graphics programming, this would be a great book to start out with. Once you've
finished this book, you'll have a good foundation for learning OpenGL itself if
you're so inclined.

For an easier start, I created a Github project with an empty SFML project
already set up. It's called [sfml-template][sfmltemplate], and it uses
[CMake][cmake] for its build system. It isn't currently set up to build on
Windows, but it will build on either Linux or Mac OS X. The linking of OpenGL on
these two platforms is quite different, which is why CMake is required for
handling building on either.

Alright, that's it. Go build something awesome!

[sfmlgamedev]:http://bit.ly/16aRxdl
[packt]:http://www.packtpub.com/
[sfml]:http://www.sfml-dev.org/
[sdl]:http://www.libsdl.org/
[savitch]:http://www.amazon.com/Absolute-5th-Edition-Walter-Savitch/dp/013283071X
[1942]:http://www.arcade-museum.com/game_detail.php?game_id=6766
[glsl]:https://www.opengl.org/documentation/glsl/
[sfmltemplate]:http://www.github.com/sensae/sfml-template/
[cmake]:http://www.cmake.org/
