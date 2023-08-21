---
layout: post
title:  "Marching Waves"
date:   2023-03-20 15:29:27 -0700
categories: projects
---

In January of 2018, I started working on a new art style using cheap gel pens, printer paper, and a lightbox for tracing. I would print out images in black and white, tape another piece of paper on top, shine the light through from underneath, and get to tracing. I drew these:

<p align="center">
  <img src="/assets/Marching Waves/portrait.png" width="full">
  <img src="/assets/Marching Waves/ellie.png" width="full/2">
</p>

I still look back on these pieces all the time, but they were painful to make. Each took several hours to draw, hunched over a desk drawing one line at a time. Needless to say, I would not be making anything larger than a standard sheet of paper using this method.

Later that year I started working with [Processing](https://processing.org). My work quickly focused on the art of image rendering, of filters and halftoning, ways of reconstructing an image from an assortment of shapes, patterns, and constraints.

Of course, I immediately wanted to replicate my drawing style in Processing. If I did that, I could use a pen plotter to make pieces as big and intricate as I wanted without having to draw them by hand. I also immediately got the feeling that it was impossible.

I started making attempts in late 2019, once I felt proficient enough at coding to give it a shot. I probably was, but my attempts went in the wrong direction. I tried to re-create the process too literally, making a virtual pen trace out each line. I ignored what was obvious to myself and many other people I showed it to — this is a mathematical function. Anyone fresh out of multivariable calc could look at these drawings and write something like this:

$$ \|\nabla u(x,y)\| = f(x,y) $$

If each drawing is a topographical map, \(u(x,y)\) defines the terrain that's being sliced to create it. The slices bunch up where the terrain is steepest, and spread out where it's more shallow. Their density is what creates the halftone effect, so that density must be controlled by the brightness of the original image. We define the function $f(x,y)$ as that measured brightness (or darkness, technically), so in plain English our equation is:

"The slope of $u(x,y)$ at any given point $(x,y)$ is defined by the value of $f(x,y)$ at that point"

Looking back at the drawings, this makes sense. The equation fits! The only problem was solving it, and I had no idea where to even begin.

I got unstuck six months later by pure chance: I finally found the name of the equation I was trying to solve. I'll admit that given how long it took me to discover this name, and how crucial it was, it feels strange even now to just give it away. Anyway, it's the [Eikonal Equation](https://en.wikipedia.org/wiki/Eikonal_equation).

Of course, this was only the starting point. I was working quite at the edge of my capabilities at the time, as a mathematician and a programmer. Even writing out what I had to do, before any coding could begin, took the better part of a week. I'll try to summarize it in a paragraph, but don't get your hopes up.

Computers need to interpret smooth, continuous functions as measured points on a discrete grid (in this case, the pixel grid of the canvas).  Rather than taking derivatives as we would on paper, they just directly measure the slope near a given point (which is just as well, because the Eikonal Equation has no closed-form solution anyway). We can sample the image at every pixel $(x,y)$ to get our $f(x,y)$ at each grid point, and assuming we know the (lowest) values $U_X ,U_Y$ of $u$ at the neighboring points in each direction, our equation can be written as:

$$ \sqrt{\left(U_{ij} - U_X\right)^2 + \left(U_{ij} - U_Y\right)^2} = f_{ij} $$

Where $U_{ij}$  is the value of $u$ at pixel $(i,j)$. Now you can spend an afternoon solving this, or just trust me when I say that the solution is:

$$ U_{ij} = \frac{U_X + U_Y}{2} + \frac{1}{2}\sqrt{\left(U_X+U_Y\right)^2 - 2 \left(U_X^2 + U_Y^2 - f_{ij}^2 \right)} $$

Great! We have the closest thing to a closed-form solution. Problem is, it relies on already knowing the value of u for at least one neighboring point. This makes sense in a way — another way to interpret the style is as waves rippling across the canvas from one point or direction. Changes in their shape early on will affect the shape they take later. Since one part of the domain can have such an effect on the other, it becomes more clear why there is no closed-form solution. There is no way to solve this equation everywhere all at once.

This is where James Sethian’s [Fast Marching Method](https://math.berkeley.edu/~sethian/2006/Explanations/fast_marching_explain.html) comes in. It's an algorithm that takes a set of points with known values, which I call the origin, and builds the solution out from them one point at a time. If you're familiar with Dijkstra's Algorithm, you'll be able to see the third interpretation of this equation's solution: the path-distance of each point from the origin, where $f$ is affecting the speed of travel. You can see it in this old map:

<p align="center">
  <img src="/assets/Marching Waves/map.png" width="full">

  Here New York is the origin, and each line represents all the points with a given path-distance, accounting for terrain and modes of travel.
</p>

This algorithm is basically Dijkstra's Algorithm, using the expression from before as its method of measuring path-distance. And once we've implemented it, we can solve the equation! After that we just have to render the drawing. I thought that would be the easy part. It was not.

I used [Marching Squares](https://en.wikipedia.org/wiki/Marching_squares) to draw the contours of the solved equation, and a custom sorting algorithm to join all the tiny line segments into continous paths. This part alone took as long as getting the thing working in the first place. But once it was completed, all I had to do was send it to a pen plotter and sit back as it drew these as big and detailed as I wanted. Finally, I thought, now here's the easy part. Dear reader, it was not.

<p align="center">
  <img src="/assets/Marching Waves/plotting.gif" width="full">
</p>

Everything described thus far took about 5% as long as it took to actually develop the manufacturing process. Many, many late nights were spent hunched over this machine, trying all kinds of different pens and papers, chasing a million dead ends, until I finally got the technique down. I use a Roland GR-420 vinyl cutter as my plotter; its motion is incredibly precise and repeatable, with no drifting or misalignment even on large, intricate drawings. Here are a few I've made on this machine:

<p align="center">
  <img src="/assets/Marching Waves/shades1.png" width="full">
  <img src="/assets/Marching Waves/shades2.png" width="full">
  <img src="/assets/Marching Waves/shades3.png" width="full">

  <img src="/assets/Marching Waves/hand1.png" width="full">
  <img src="/assets/Marching Waves/hand2.png" width="full">
  <img src="/assets/Marching Waves/nipsey1.png" width="full">
  <img src="/assets/Marching Waves/nipsey2.png" width="full">
  <img src="/assets/Marching Waves/nipsey3.png" width="full">
</p>