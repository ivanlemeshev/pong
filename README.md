# Pong

Minimal [LÖVE](https://www.love2d.org) project for learning.

![Pong demo](pong.gif)

This game is based on [Lecture 0](https://www.youtube.com/watch?v=MY2y3dDwgMk)
from CS50's Introduction to 2D Game Development.

## How to play

The game uses a simple state flow:

- `start` screen
- `play`
- `pause`
- `game over`

Goal:

- score 9 points before your opponent

Controls:

- `Enter` - start the match from the title screen
- `D` - move player 1 up
- `S` - move player 1 down
- `K` - move player 2 up
- `J` - move player 2 down
- `Space` - pause during play
- `Space` - resume from pause
- `Enter` - return to the start screen from game over
- `Escape` - quit the game

Rules:

- the ball bounces off the top and bottom edges
- the ball bounces off paddles and speeds up slightly after each hit
- when the ball leaves the left side, player 2 scores
- when the ball leaves the right side, player 1 scores
- the first player to reach 9 points wins

## Make targets

Available targets:

- `make init` - fetch all local dependencies
- `make update` - re-fetch all local dependencies
- `make clean` - remove all local cached dependencies
- `make run` - start the game with [LÖVE](https://www.love2d.org), requires
  `love` to be on your [PATH](https://www.love2d.org/wiki/Getting_Started)
