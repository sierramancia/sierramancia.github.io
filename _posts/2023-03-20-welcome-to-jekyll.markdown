---
layout: post
title:  "Marching Waves"
date:   2023-03-20 15:29:27 -0700
categories: projects
---

In January of 2018, I started working on a new art style using cheap gel pens, printer paper, and a lightbox for tracing. I would print out images in black and white, tape another piece of paper on top, shine the light through from underneath, and get to tracing.

<p align="center">
  <img src="/assets/images/portrait.png" height="450">
  <img src="/assets/images/ellie.png" height="450">
</p>

These pieces each took several hours to draw, hunched over a desk adding one line at a time with the pen. Needless to say, I would not be making anything larger than a standard sheet of paper using this method. I started working with Processing later that year, and soon enough I was playing around with the idea of replicating this style digitally.

This was not an easy task, to say the least. After running into a few dead ends and taking some time away, I had a breakthrough in Summer 2020: I found the name of the equation I was trying to solve.

$$ \|\nabla u(x,y)\| = \frac{1}{f(x,y)} $$

This is the [Eikonal Equation](https://en.wikipedia.org/wiki/Eikonal_equation). In mathematics you learn to fear the simple things: the one-sentence exam problem, the elegant geometric drawing, and brief equations such as this one. It's simple enough: starting with $f(x,y)$, which in this case is the brightness of our original image, we want the function $u(x,y)$ such that the "steepness" of $u$'s surface, or the magnitude of its gradient, is equal to $1/f$ at any given point.

This way, when we make a topographical map of $g$ by drawing its level sets, those lines bunch up at the steeper areas to make the eye perceive a darker tone there.

It's simple enough to describe what we're trying to do, but our fearful instincts are correct — solving the equation is no easy feat. We can discretize the domain into a regular grid (in this case, just the pixel grid of the image) and get an approximate solution for each grid point:
$$U_{ij} = \frac{U_X + U_Y}{2} + \frac{1}{2}\sqrt{(U_X+U_Y)^2 - 2 \left(U_X^2 + U_Y^2 - \frac{1}{f_{ij}^2} \right)}$$

where $U_{ij} = u(i,j)$, $f_{ij}=f(i,j)$, $U_X = \min(U_{i-1,j}, U_{i+1,j})$, and $U_Y = \min(U_{i,j-1}, U_{i,j+1})$.

Now we can use James Sethian's [Fast Marching Method](https://math.berkeley.edu/~sethian/2006/Explanations/fast_marching_explain.html), an algorithm
