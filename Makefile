# Makefile for ARB string management

ARB_DIR = lib/src/strings/l10n

.PHONY: help add remove update

help:
	@echo "Available commands:"
	@echo "  make add KEY=<key> VALUE=\"<value>\"    - Add string"
	@echo "  make remove KEY=<key>                   - Remove string"
	@echo "  make update KEY=<key> VALUE=\"<value>\" - Update string"
	@echo ""
	@echo "Examples:"
	@echo "  make add KEY=welcome_message VALUE=\"Welcome\""
	@echo "  make remove KEY=welcome_message"
	@echo "  make update KEY=welcome_message VALUE=\"New welcome message\""

add-string:
	@if [ -z "$(KEY)" ] || [ -z "$(VALUE)" ]; then \
		echo "Error: KEY and VALUE are required"; \
		exit 1; \
	fi
	@cd $(ARB_DIR) && dart add_string.dart $(KEY) "$(VALUE)"
	flutter pub get

remove-string:
	@if [ -z "$(KEY)" ]; then \
		echo "Error: KEY is required"; \
		exit 1; \
	fi
	@cd $(ARB_DIR) && dart remove_string.dart $(KEY)
	flutter pub get

update-strings:
	@if [ -z "$(KEY)" ] || [ -z "$(VALUE)" ]; then \
		echo "Error: KEY and VALUE are required"; \
		exit 1; \
	fi
	@cd $(ARB_DIR) && dart update_string.dart $(KEY) "$(VALUE)"
	flutter pub get