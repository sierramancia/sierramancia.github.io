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

## Scribbling

Samer Dabra ([@spongenuity](https://www.instagram.com/spongenuity/)) has a procedural, stochastic style originally made for pen plotters. He used it with machine embroidery a few times and it looks fantastic:

[photo]

It's pretty easy to program; just make a line that wanders in the direction of darker areas on the image. To keep it from getting stuck, draw a corresponding white line on the image so it can avoid areas it's already drawn over.

In my program the randomness is inserted into the length of each step, which corresponds to a stitch. With a chosen step length, a number of sample points are taken at that distance from the head of the line. The one with the darkest value is where the line goes next.

[photo]

You can see that my design is a lot coarser than Samer's. I wanted to optimize this program for the machine and require less stitches

## Choices

There are so many other ways to make this line wander, though. You could randomly choose the direction first and then select the optimal distance, which looks like this:

[photo]

Instead of an arc or a line of sample points, you can make a varied fan that biases towards the current direction of travel:

[photo]

The sampling can also be biased, keeping the line along the same curve of 