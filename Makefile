POWERSHELL := pwsh -NoProfile -Command

LOVE_TYPES_DIR := .cache/luals/love2d
LOVE_TYPES_REPO := https://github.com/LuaCATS/love2d.git

.PHONY: init setup love-types clean-love-types help

init: love-types

setup: init

help:
	@echo "make init             # fetch local Love2D LuaLS cache"
	@echo "make love-types       # re-fetch local Love2D LuaLS cache"
	@echo "make clean-love-types # remove local Love2D LuaLS cache"

love-types:
	@$(POWERSHELL) "$$ErrorActionPreference = 'Stop'; $$dir = '$(LOVE_TYPES_DIR)'; $$repo = '$(LOVE_TYPES_REPO)'; if (Test-Path $$dir) { Remove-Item -Recurse -Force $$dir }; git clone --depth 1 $$repo $$dir; Remove-Item -Recurse -Force (Join-Path $$dir '.git')"

clean-love-types:
	@$(POWERSHELL) "$$dir = '$(LOVE_TYPES_DIR)'; if (Test-Path $$dir) { Remove-Item -Recurse -Force $$dir; exit 0 }; exit 0"
