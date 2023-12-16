---
layout: post
title:  "Embroidery"
date:   2023-12-13 15:29:27 -0700
categories: articles
---

Getting to work with an embroidery machine is a deep lesson in working within a limited creative space. Its main constraints are color and continuity; changing threads is a pain and not something you want to do often. It can cut threads on its own, but this takes time and leaves loose ends than all need to be trimmed.

These constraints are soft; if you're willing to dedicate the time, you can make colorful and discontinuous designs. But the challenge of working within them interested me — what's the best way to render an image using a single continuous thread?

The first approach was pretty simple — a classic scan-line halftone pattern, which creates vertical peaks of varying height and separation. In practice it's cool to see them squish up against each other:

This was one of my first Processing sketches ever, and it's a perfect beginner project. I encourage you to try it out, especially if you have access to a digital embroidery machine.

The next thing to try was color; a basic CMYK printing technique wouldn't take too much time. I did this quite manually, extracting the four layers in Photoshop and rotating them before loading them into the sketch.

If I'd been happier with the results, I might have fully automated the CMYK split, but the effect doesn't come through unless you back up and really squint. The lines could be made smaller, but there's another limit; you don't want to be making a bunch of stitches right next to each other with sub-millimeter spacing.

The other issue is pulling; too many back-and-forth stitches in the same direction will pull the fabric together along that axis. A design with thread going in all directions would solve this, and perhaps solve the issue of detail.

## Scribbling

Samer Dabra ([@spongenuity](https://www.instagram.com/spongenuity/)) has a procedural, stochastic style originally made for pen plotters. He used it with machine embroidery a few times and it looks fantastic:

[photo]

It's pretty easy to program a simple version of this; just make a [turtle](https://en.wikipedia.org/wiki/Turtle_graphics) that wanders in the direction of darker areas on the image. To keep it from getting stuck, draw a corresponding white line on the image so it can avoid areas it's already drawn over.

With a chosen step length, a number of sample points are taken at that distance from the head of the line. The one with the darkest value is where the line goes next.

[screenshot]

Here's what this gives us:

[photo]

As you can see, this is not good. Let's see what we can change about the turtle's behavior to make it better.

## Choices

The first problem I'm noticing is the uniformity; the turtle seems to be evenly shading every area under a certain threshold without scribbling more over the darkest parts of the image. I think this is because the white trail it leaves on the image is too opaque — it's set to 50% opacity right now. After one or two passes, even the darkest areas get washed out before the turtle can properly cover them. Let's try about 10%:

Instead of an arc or a line of sample points, you can make a varied fan that biases towards the current direction of travel:

[photo]

The sampling can also be biased, keeping the line along the same curve of 