# Local testing of the Typst template package.
#
#   make test        init a project from the template and compile it
#   make thumbnail   render page 1 of the template as thumbnail.png
#   make clean       remove the build directory
#   make link        link the repo into the system package folder (for editors)
#   make unlink      remove that link again
#
# test/thumbnail symlink the repo into a private package directory
# (TYPST_PACKAGE_PATH), so "@preview/<name>:<version>" resolves to this checkout
# without touching the system-wide Typst package folder. Editors such as the
# VS Code Tinymist preview only search the system folder; use `make link` there.

NAME    := $(shell sed -n 's/^name *= *"\(.*\)"/\1/p' typst.toml)
VERSION := $(shell sed -n 's/^version *= *"\(.*\)"/\1/p' typst.toml)

BUILD := /tmp/$(NAME)-test
DOC   := $(BUILD)/project/main.typ
LINK  := $(HOME)/Library/Application Support/typst/packages/preview/$(NAME)/$(VERSION)

.PHONY: test thumbnail clean link unlink

link:
	@mkdir -p "$$(dirname "$(LINK)")"
	ln -sfn "$(CURDIR)" "$(LINK)"

unlink:
	rm -f "$(LINK)"

test: export TYPST_PACKAGE_PATH := $(BUILD)/packages
thumbnail: export TYPST_PACKAGE_PATH := $(BUILD)/packages

test:
	@rm -rf "$(BUILD)"
	@mkdir -p "$(TYPST_PACKAGE_PATH)/preview/$(NAME)"
	@ln -s "$(CURDIR)" "$(TYPST_PACKAGE_PATH)/preview/$(NAME)/$(VERSION)"
	typst init "@preview/$(NAME):$(VERSION)" "$(BUILD)/project"
	typst compile "$(DOC)"

thumbnail: test
	typst compile -f pdf --ppi 250 "$(DOC)" example.pdf
	typst compile -f png --pages 1 --ppi 250 "$(DOC)" thumbnail.png

clean:
	rm -rf "$(BUILD)"
