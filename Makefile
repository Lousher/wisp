.PHONY: clean run all

DIST := dist
WASM_MAIN := $(DIST)/main.wasm
WISH_MAIN := $(DIST)/main.wish

WISP_FILES := $(wildcard *.wisp)
SCM_FILES := $(patsubst %.wisp, $(DIST)/%.scm, $(WISP_FILES))

WISP_COMP := ./wisp
WASM_COMP := lima guild compile-wasm

all: $(WASM_MAIN)

$(WASM_MAIN): $(SCM_FILES)
	@cp -r template/ dist/
	$(WASM_COMP) -o $@ $(WISH_MAIN) -L modules -L dist

$(DIST)/%.scm: %.wish
	@mkdir -p $(@D)
	mv $< $@

%.wish: %.wisp
	$(WISP_COMP) $<

clean:
	@rm -rf dist/ *.wish

run:
	npx serve dist/
