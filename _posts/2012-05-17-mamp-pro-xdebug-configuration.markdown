---
date: 2012-05-17 23:15:15+00:00
layout: post
title: MAMP Pro XDebug Configuration
---

I've recently had to set up XDebug with MAMP Pro on OS X and it's a little
unintuitive. The instructions over at MacGDBp helped me tremendously, and
they've made a nice debugger.

The latest version of MAMP/MAMP Pro comes with the XDebug binary already
bundled. The unintuitive part is that you'll need to edit your MAMP Pro php.ini
file to point to the xdebug.so file in the MAMP folder. While MAMP Pro is open,
go to File -> Edit Template -> PHP -> (PHP Version you use), and add the
following lines to your php.ini.

    ; XDebug
    zend_extension="/Applications/MAMP/bin/php/php5.3.6/lib/php/extensions/no-debug-non-zts-20090626/xdebug.so"
    xdebug.remote_enable=1
    xdebug.remote_host=localhost
    xdebug.remote_port=9000
    xdebug.remote_autostart=1
