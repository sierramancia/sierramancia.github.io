---
layout: post
title:  "Reflection"
date:   2023-03-20 15:29:27 -0700
categories: projects
permalink: /reflection/
---

Outline:
- Inspiration
- First installation w/ projector
    - Sensors
    - Math
    - Installation
- Building a display
    - Idea
    - Makerspace collab
    - Wiring + assembly
- Software

My first software projects were webcam filters — interactive sketches that invite the viewer to participate. It was already a well-traveled path, with artists like Danny Rozin and Breakfast Studio using depth-sensing cameras to extract a simple silhouette of the user.

These kinds of pieces are quite a crowd favorite, but I saw the potential for a piece that brings the audience even closer by creating a *perfect* mirror silhouette — as in, you can hold your hand right up to the piece and see its silhouette right on the other side of the imaginary glass as if it were a shadow cast by the setting sun.



I achieved this by orthographically projecting a point cloud onto the display, so that each point in 3D space was rendered right at its closest position on the display. 

I wanted to make a real display, of course. The projector was a poor substitute, but building a display large enough to stand in front of was out of my budget. The project was shelved, as projects often are, until I transfered to UCLA and started hanging out at the Makerspace. I noticed that they had a lot of NeoPixel strips — about 100 meters, worth a few thousand dollars. I asked some version of "can I use basically all of these to make this project?", and was asked some version of "what else do you need?".



The ideal version of this piece would be a display where each pixel has a depth sensor looking straight out, so that each pixel can see and respond to objects within its "column". Of course, a suitable time-of-flight sensor on each 