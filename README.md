# pong

Minimal LÖVE project for learning and building Pong.

## Requirements

- [LÖVE](https://love2d.org/)
- `git`
- `make`
- PowerShell (`pwsh`)

<!-- prettier-ignore -->
> [!NOTE]
> All make targets are written in PowerShell, so Windows users should be able to
> run them out of the box. This repo is not tested on other platforms.

## Setup

Run one command from the project root:

```shell
make init
```

This fetches:

- local editor-only LÖVE type definitions into `.cache/luals/love2d`
- runtime dependency `.cache/deps/push.lua` from `Ulydev/push` `dev` branch

## Run the game

<!-- prettier-ignore -->
> [!NOTE]
> Make sure you have LÖVE installed and added to your system's PATH variable.
> You can verify this by running `love --version` in your terminal.

```shell
love .
```

## Make targets

Available targets:

- `make init` - fetch all local dependencies
- `make update` - re-fetch all local dependencies
- `make clean` - remove all local cached dependencies
