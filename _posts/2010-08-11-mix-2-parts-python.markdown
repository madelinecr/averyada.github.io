---
date: 2010-08-11 15:25:39+00:00
layout: post
title: Mix 2 Parts Python
categories:
- Coding
tags:
- python
---

I've had a personal project in Panda3D in the works on and off (mostly off) for
the past few months mostly as a leisure activity. It's a very elegant engine to
work in, but the scene graph concept is one that can be difficult to grasp at
first.

It's nonintuitive dealing with NodePaths, ActorNodes, PandaNodes, GeomNodes and
keeping all of them straight. However, the most appealing aspect of Panda3D and
one of the main benefits to it's usability is the fact it exposes it's APIs in
Python.

Playing around in the interactive python interpreter and leveraging a debug
function makes learning a lot less painful. For example:


    >>> import direct.directbase.DirectStart
    >>> from panda3d.core import *
    >>> pn = PandaNode("MyPandaNode")
    >>> Node = NodePath(pn)
    >>> Node.ls()
    PandaNode MyPandaNode
    >>> Node2 = Node.attachNewNode(PandaNode("MySecondPandaNode"))
    >>> Node2.ls()
    PandaNode MySecondPandaNode
    >>> Node.ls()
    PandaNode MyPandaNode
    PandaNode MySecondPandaNode
    >>> Node.reparentTo(render)
    >>> render.ls()
    PandaNode render S:(CullFaceAttrib RescaleNormalAttrib)
    ModelNode camera
    Camera cam ( PerspectiveLens )
    PerspectiveLens fov = 38.5468 30
    PandaNode MyPandaNode
    PandaNode MySecondPandaNode


Following the above steps was crucial to my understanding of the scene graph
hierarchy, and being able to interactively list that hierarchy as the tree is
manipulated is a huge selling point when it comes to learning ease.

For me, thinking of a NodePath as a pointer to a node made the engine concepts
much less confusing, and this real time interaction made it much easier to
figure out how NodePaths and nodes behave.
