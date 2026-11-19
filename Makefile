# Local testing of the Typst template package.
#
#   make test        init a project from the template and compile it
#   make thumbnail   compose thumbnail.png from the components (template/main.typ)
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

.PHONY: install_extras test thumbnail examples clean link unlink packages check

install_extras:
	cargo install oxipng
	cargo install --git https://github.com/typst/package-check.git

link:
	@mkdir -p "$$(dirname "$(LINK)")"
	ln -sfn "$(CURDIR)" "$(LINK)"

unlink:
	rm -f "$(LINK)"

test: export TYPST_PACKAGE_PATH := $(BUILD)/packages
thumbnail: export TYPST_PACKAGE_PATH := $(BUILD)/packages
examples: export TYPST_PACKAGE_PATH := $(BUILD)/packages

packages:
	@mkdir -p "$(BUILD)/packages/preview/$(NAME)"
	@ln -sfn "$(CURDIR)" "$(BUILD)/packages/preview/$(NAME)/$(VERSION)"

test: packages
	@rm -rf "$(BUILD)/project"
	typst init "@preview/$(NAME):$(VERSION)" "$(BUILD)/project"
	typst compile "$(DOC)"

thumbnail: packages
	typst compile --root . -f png --ppi 300 template/main.typ thumbnail.png
	oxipng --strip safe --alpha thumbnail.png
	cp thumbnail.png docs/preview.png

examples: packages
	typst compile --root . -f pdf template/poster.typ docs/example_poster.pdf
	typst compile --root . -f pdf template/slides.typ docs/example_slides.pdf
	typst compile --root . -f pdf template/article.typ docs/example_article.pdf

clean:
	rm -rf "$(BUILD)"

check:
	typst-package-check check