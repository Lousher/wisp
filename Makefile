.PHONY: clean test

COMPILER := lima guild compile-wasm
DIST_DIR := dist/
WASM_TAR := main.wasm
WISH_SRC := main.wish
TESTS := $(wildcard test/*.scm.test)
MODULES := modules

build:
	@mkdir dist
	@cp -r template/ dist/
	@cp App.wish dist/App.scm
	@cp main.wish dist/main.wish
	@$(COMPILER) -o $(DIST_DIR)$(WASM_TAR) $(DIST_DIR)$(WISH_SRC) -L $(MODULES) -L $(DIST_DIR)
	@rm dist/main.wish

test:
	@for test_file in $(TESTS); do \
		guile --r6rs -L $(MODULES) -s $$test_file; \
	done;
	@mv *.log test/log/

clean:
	@rm -rf dist/

run:
	@npx serve dist/
