LINTER := yamllint
FORMATTER := yamlfmt

YAML_FILES := $(shell find . -name "*.yml" -o -name "*.yaml")

.PHONY: check-linter
check-linter:
	@which $(LINTER) > /dev/null || (echo "$(LINTER) not found. Installing..." && brew install $(LINTER))

.PHONY: check-fmt
check-fmt:
	@which $(FORMATTER) > /dev/null || (echo "$(FORMATTER) not found. Installing..." && go install github.com/google/yamlfmt/cmd/yamlfmt@v0.16.0)

.PHONY: lint
lint: check-linter
	@if [ -n "$(YAML_FILES)" ]; then \
		for file in $(YAML_FILES); do \
			$(LINTER) --format github $$file; \
		done; \
	fi

.PHONY: fmt
fmt: check-fmt
	@if [ -n "$(YAML_FILES)" ]; then \
		$(FORMATTER) $(YAML_FILES); \
	fi
