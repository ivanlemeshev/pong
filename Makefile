POWERSHELL := pwsh -NoProfile -Command

LOVE_TYPES_DIR := .cache/luals/love2d
LOVE_TYPES_REPO := https://github.com/LuaCATS/love2d.git

CACHE_DIR := .cache

.PHONY: init update clean

init:
	@$(POWERSHELL) "$$typesDir = '$(LOVE_TYPES_DIR)'; if (Test-Path $$typesDir) { Remove-Item -Recurse -Force $$typesDir }"
	@git clone --depth 1 $(LOVE_TYPES_REPO) $(LOVE_TYPES_DIR)
	@$(POWERSHELL) "$$typesDir = '$(LOVE_TYPES_DIR)'; Remove-Item -Recurse -Force (Join-Path $$typesDir '.git')"

update: init

clean:
	@$(POWERSHELL) "$$dir = '$(CACHE_DIR)'; if (Test-Path $$dir) { Remove-Item -Recurse -Force $$dir }; exit 0"
