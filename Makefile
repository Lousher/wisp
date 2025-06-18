.PHONY: clean test

TESTS := $(wildcard test/*.scm.test)
MODULES := modules

build:
	@echo "A Place Holder"

test:
	@guile -L $(MODULES) -s $(TESTS)
	@mv *.log test/log/
