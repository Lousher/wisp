.PHONY: clean test

TESTS := $(wildcard test/*.scm.test)
MODULES := modules

build:
	@echo "A Place Holder"

test:
	@for test_file in $(TESTS); do \
		guile --r6rs -L $(MODULES) -s $$test_file; \
	done;
	@mv *.log test/log/
