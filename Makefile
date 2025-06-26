.PHONY: clean all

DIST_DIR := dist
MODULES := modules
TEMPLATE := template
MAIN_WASM := main.wasm
MAIN_WISP := main.wisp
WISP_FILES := $(wildcard *.wisp)
OTHER_SCM := $(patsubst %.wisp, $(DIST_DIR)/%.scm, $(WISP_FILES))
COMP := lima guild compile-wasm

all: $(DIST_DIR)/$(MAIN_WASM)

$(DIST_DIR)/$(MAIN_WASM): $(OTHER_SCM)
	$(COMP) -o $(DIST_DIR)/$(MAIN_WASM) $(DIST_DIR)/$(MAIN_WISP) -L $(MODULES) -L $(DIST_DIR)

$(DIST_DIR)/%.scm: %.wisp setup-dist
	@cp $< $@

setup-dist:
	@mkdir -p $(DIST_DIR)
	@mkdir -p $(DIST_DIR)/assets
	@cp -r $(TEMPLATE)/ $(DIST_DIR)/
	@cp -r assets/ $(DIST_DIR)/assets/
	

clean:
	rm -rf $(DIST_DIR)/

run:
	npx serve $(DIST_DIR)
